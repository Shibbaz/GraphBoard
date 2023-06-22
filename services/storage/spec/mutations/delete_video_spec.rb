RSpec.describe Mutations::DeleteVideo, type: :request do
    let(:video) { create(:video) }

    describe 'Mutation Success' do
        it 'expects to delete video successfully' do
            mutation = Mutations::DeleteVideo.new(object: nil, field: nil, context: {
                current_user_id: SecureRandom.uuid
            }).resolve(video_id: video.id)
            expect(mutation[:status]).to eq(200)
        end

        it 'expects not to delete video, video does not exist' do
            random_video_id = SecureRandom.uuid
            expect(Mutations::DeleteVideo.new(object: nil, field: nil, context: {
                    current_user_id: SecureRandom.uuid
                }).resolve(video_id: random_video_id)
            ).to eq(GraphQL::ExecutionError.new "Couldn't find Video with 'id'=#{random_video_id}")            
        end

        it 'expects to fails deleting video' do        
            expect(Mutations::DeleteVideo.new(object: nil, field: nil, context: {
                current_user_id: nil
            }).resolve(video_id: nil)).to eq(GraphQL::ExecutionError.new('Authentication Error'))
        end
    end
end