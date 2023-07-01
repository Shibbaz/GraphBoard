RSpec.describe Mutations::UpdateVideo, type: :request do
  let(:video) { create(:video) }
  let(:quote) { Faker::JapaneseMedia::OnePiece.quote }
  let(:informations) {
    {
      name: "Two Piece",
      description: quote,
      video_type: "video"
    }
  }
  describe "Mutation Success" do
    it "expects to update user successfully" do
      mutation = Mutations::UpdateVideo.new(object: nil, field: nil, context: {
        current_user_id: SecureRandom.uuid
      }).resolve(
        video_id: video.id,
        informations: informations
      )
      expect(Video.first.description).to eq(quote)
      expect(Video.first.name).to eq("Two Piece")

      expect(mutation[:status]).to eq(200)
    end

    it "expects not to update video, video does not exist" do
      random_video_id = SecureRandom.uuid
      expect{Mutations::UpdateVideo.new(object: nil, field: nil, context: {
        current_user_id: SecureRandom.uuid,
      }).resolve(video_id: random_video_id, informations: informations)}.to raise_error(GraphQL::ExecutionError, "ActiveRecord::RecordNotFound")
    end

    it "expects authentication to fail" do
      expect {
        Mutations::UpdateVideo.new(object: nil, field: nil, context: {
          current_user_id: nil
        }).resolve(
          informations: {
            name: "One Piece",
            description: Faker::JapaneseMedia::OnePiece.quote,
            video_type: "video"
          },
          video_id: video.id
        )
      }.to raise_error(GraphQL::ExecutionError, "Authentication Error")
    end
  end
end
