require "rails_helper"

RSpec.describe Resolvers::VideoSearch, type: :graphql do
  before { create_list(:video, 10) }

  let(:context) do
    {
      current_user_id: SecureRandom.uuid
    }
  end

  describe "#resolve with no params" do
    let(:query) do
      <<-GQL
                query Videos {
                    videos {
                        name
                        description
                        videoType
                        rules
                    }
                }   
      GQL
    end

    it "executes query" do
      resolver = StoragesSchema.execute(query, context: context, variables: {}).to_h
      resolverVideos = resolver["data"]["videos"].first
    end

    it "does not execute query" do
      resolver = StoragesSchema.execute(query, context: {
        current_user_id: nil
      }, variables: {}).to_h
      expect(resolver["errors"].pluck("message").first).to eq("Authentication Error")
    end
  end

  describe "#resolve filtering by name" do
    let(:query) do
      <<-GQL
                query Videos($name: String) {
                    videos(name: $name){
                        name
                        description
                        videoType
                        rules
                    }
                }
      GQL
    end

    it "executes query" do
      Video.first.update(name: "One Piece Red")
      Video.first.reload
      resolverVideos = StoragesSchema.execute(query, context: context, variables: {
        name: Video.first.name
      }).to_h["data"]["videos"]
      videosCount = resolverVideos.size
      expect(videosCount).to be(1)
      expect(resolverVideos.first["name"]).to eql("One Piece Red")
      expect(resolverVideos.first["description"]).to eql(Video.first.description)
      expect(resolverVideos.first["videoType"]).to eql(Video.first.video_type)
      expect(resolverVideos.first["rules"].size).to eql(1)
    end

    it "does not execute query" do
      resolver = StoragesSchema.execute(query, context: {
        current_user_id: nil
      }, variables: {}).to_h
      expect(resolver["errors"].pluck("message").first).to eq("Authentication Error")
    end
  end

  describe "#resolve with param type" do
    let(:query) do
      <<-GQL
                query Videos($videoType: String) {
                    videos(videoType: $videoType) {
                        name
                        description
                        videoType
                        rules
                    }
                }
      GQL
    end

    it "executes query" do
      Video.first.update(video_type: "Animated video")
      resolver = StoragesSchema.execute(query, context: context, variables: {
        videoType: "Animated video"
      }).to_h

      resolverVideos = resolver["data"]["videos"]
      videosCount = resolverVideos.size
      expect(videosCount).to be(1)
      expect(resolverVideos.first["description"]).to eql(Video.first.description)
      expect(resolverVideos.first["videoType"]).to eql("Animated video")
      expect(resolverVideos.first["rules"].size).to eql(1)
    end

    it "does not execute query" do
      resolver = StoragesSchema.execute(query, context: {
        current_user: nil
      }, variables: {}).to_h
      expect(resolver["errors"].pluck("message").first).to eq("Authentication Error")
    end
  end

  describe "#resolve with param createdAt" do
    let(:query) do
      <<-GQL
                query Videos($createdAt: Boolean) {
                    videos(createdAt: $createdAt) {
                        name
                        createdAt
                    }
                }
      GQL
    end

    it "executes query by asc" do
      resolverVideos = StoragesSchema.execute(query, context: context, variables: {
        createdAt: true
      }).to_h["data"]["videos"]
      expect(
        Date.parse(resolverVideos.first["createdAt"]) > Date.parse(resolverVideos.last["createdAt"])
      ).to be(false)
    end

    it "executes query by desc" do
      resolverVideos = StoragesSchema.execute(query, context: context, variables: {
        createdAt: false
      }).to_h["data"]["videos"]
      expect(
        Date.parse(resolverVideos.first["createdAt"]) > Date.parse(resolverVideos.last["createdAt"])
      ).to be(true)
    end

    it "does not execute query" do
      resolver = StoragesSchema.execute(query, context: {
        current_user: nil
      }, variables: {}).to_h
      expect(resolver["errors"].pluck("message").first).to eq("Authentication Error")
    end
  end
end
