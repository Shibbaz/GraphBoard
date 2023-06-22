# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::CreateVideo, type: :request do
  let(:video) do
    fixture_file_upload(Rails.root.join("spec", "fixtures", "luffy.mov"), "video/mp4")
  end

  let(:not_a_video) do
    fixture_file_upload(Rails.root.join("spec", "fixtures", "luffy.jpg"), "image/jpg")
  end

  let(:input) do
    {
      id: SecureRandom.uuid,
      name: "One Piece",
      description: Faker::JapaneseMedia::OnePiece.quote,
      video_type: "video",
      author: SecureRandom.uuid,
      rules: [{age: 12}]
    }
  end

  let(:failed_input) do
    {
      id: SecureRandom.uuid,
      name: "One Piece",
      description: Faker::JapaneseMedia::OnePiece.quote,
      video_type: "image",
      author: SecureRandom.uuid,
      rules: [{age: 12}]
    }
  end

  describe "Mutation Success" do
    it "expects to create video successfully" do
      expect do
        Mutations::CreateVideo.new(object: nil, field: nil, context: {
          current_user_id: SecureRandom.uuid
        }).resolve(
          input: input,
          file: video
        )
      end.to_not raise_error
      expect { Rails.configuration.s3.get_object(bucket: "files", key: Video.first.id) }.to_not raise_error
    end
  end

  describe "Mutation Failure" do
    it "expects to not upload file" do
      expect {
        Mutations::CreateVideo.new(object: nil, field: nil, context: {
          current_user_id: SecureRandom.uuid
        }).resolve(
          input: failed_input,
          file: not_a_video
        )
      }.to raise_error(GraphQL::ExecutionError, "File is not found")
    end

    it "expects authentication to fail" do
      expect {
        Mutations::CreateVideo.new(object: nil, field: nil, context: {
          current_user_id: nil
        }).resolve(
          input: failed_input,
          file: video
        )
      }.to raise_error(GraphQL::ExecutionError)
    end
  end
end
