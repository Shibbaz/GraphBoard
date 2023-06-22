RSpec.describe Mutations::UpdateVideo, type: :request do
    let(:video) { create(:video) }

    describe 'Mutation Success' do
        it 'expects to update user successfully' do
            quote = Faker::JapaneseMedia::OnePiece.quote
            mutation = Mutations::UpdateVideo.new(object: nil, field: nil, context: {
                current_user_id: SecureRandom.uuid
            }).resolve(
                video_id: video.id,
                input: {
                    name: "Two Piece",
                    description: quote,
                    video_type: "video",
                }
            )
            expect(Video.first.description).to eq(quote)
            expect(Video.first.name).to eq("Two Piece")

            expect(mutation[:status]).to eq(200)
        end

        it 'expects authentication to fail' do
            expect { Mutations::UpdateVideo.new(object: nil, field: nil, context: {
              current_user_id: nil
            }).resolve(
              input: {
                name: "One Piece",
                description: Faker::JapaneseMedia::OnePiece.quote,
                video_type: "video",
              },
              video_id: video.id
              )}.to raise_error(GraphQL::ExecutionError, "Authentication Error")
            end
    end
end