# frozen_string_literal: true

require "rails_helper"
require "faker"

RSpec.describe Storage::Delete, type: :model do
  subject(:context) do
    Storage::Delete
  end
  context "delete method" do
    let(:fake_s3) { {} }

    let(:client) do
      client = Aws::S3::Client.new(stub_responses: true)
      client.stub_responses(
        :create_bucket, lambda { |context|
          name = context.params[:bucket]
          if fake_s3[name]
            "BucketAlreadyExists" # standalone strings are treated as exceptions
          else
            fake_s3[name] = {}
            {}
          end
        }
      )
      client
    end

    it "expects successfully deleting file" do
      bucket_key = "foo"
      client.create_bucket(bucket: bucket_key)
      file_key = "obj"
      file = fixture_file_upload(Rails.root.join("spec", "fixtures", "luffy.mov"), "video/mp4")
      upload = Storage::Delete.call(
        storage: client,
        bucket: bucket_key,
        key: file_key
      )
      expect do
        upload
      end.to_not raise_error

      expect do
        Storage::Delete.call(
          storage: client,
          bucket: bucket_key,
          key: file_key
        )
      end.to_not raise_error
    end

    it "expects deleting file failure" do
      bucket_key = "foo"
      client.create_bucket(bucket: bucket_key)
      expect do
        Storage::Delete.call(
          storage: client,
          bucket: bucket_key,
          key: nil
        )
      end.to raise_error(
        FileNoKeyError
      )
    end
  end
end
