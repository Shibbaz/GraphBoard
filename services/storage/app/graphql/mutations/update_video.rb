module Mutations
  class UpdateVideo < Mutations::BaseMutation
    field :video, Types::VideoType, null: true

    argument :video_id, ID, required: true
    argument :input, Types::Input::VideoInput, required: true
    
    def resolve(video_id:, input:)
      Authenticate.call(context: context)
      Concepts::Videos::Repository.new.update(video_id: video_id, args: input)
    end
  end
end