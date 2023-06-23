require 'rails_helper'

RSpec.describe Concepts::Videos::Repository, type: :request do
    subject(:repository) { Concepts::Videos::Repository.new }    

    describe 'method create' do
        let(:args) do
            {
                name: "One Piece",
                description: Faker::JapaneseMedia::OnePiece.quote,
                video_type: "video",
                author: SecureRandom.uuid,
                rules: [{age: 12}]
            }
        end

        let(:file) do
            fixture_file_upload(Rails.root.join("spec", "fixtures", "luffy.mov"), "video/mp4")
        end

        it 'expects to create video successfully' do
            event = repository.create(args: args, file: file)
            expect(event).to(have_published(VideoWasCreated))
            proof = Video.first
            expect{ proof }.to_not raise_error
            expect(proof[:name]).to eq(args[:name])
            expect(proof[:description]).to eq(args[:description])
            expect(proof[:video_type]).to eq(args[:video_type])
            expect(proof[:rules][0].keys[0].to_sym).to eq(args[:rules][0].keys[0])
            expect(proof[:rules][0]["age"]).to eq(args[:rules][0][:age])
        end

        it 'expects not to create video' do
            expect{
                repository.create(
                    args: {
                        name: "One Piece",
                        description: Faker::JapaneseMedia::OnePiece.quote,
                        video_type: "video",
                        author: SecureRandom.uuid,
                        rules: [{age: 12}]
                    },
                    file: nil
                ) }.to raise_error(
                    FileInvalidTypeError
                )
        end
    end

    describe 'method delete' do
        let(:video) { create(:video) }

        it 'expects to delete video successfully' do
            event = repository.delete(
                video_id: video.id
            )
            expect(event).to(have_published(VideoWasDeleted))
            expect{ video.reload }.to raise_error(ActiveRecord::RecordNotFound)
        end

        it 'expects to delete non-existing video' do
            expect{ 
                repository.delete(
                    video_id: SecureRandom.uuid
                ) }.to raise_error(
                    ActiveRecord::RecordNotFound
                )
        end
    end

    describe 'method update' do
        let(:video) { create(:video) }

        it 'expects to update video successfully' do
            quote = Faker::JapaneseMedia::OnePiece.quote
            event = repository.update(
                video_id: video.id,
                args: {
                    name: "Two Piece",
                    description: quote,
                    video_type: "video"
                }
            )            
            expect(event).to(have_published(VideoWasUpdated))
            video.reload
            expect(video[:name]).to eq("Two Piece")
            expect(video[:description]).to eq(quote)
            expect(video[:video_type]).to eq("video")
        end

        it 'expects to update non-existing video' do
            expect{ 
                repository.update(
                    video_id: SecureRandom.uuid,
                    args: {}
                ) }.to raise_error(
                    ActiveRecord::RecordNotFound
                )
        end
    end
end
