module Mutations
  class UpdateVideo < Mutations::BaseMutation
    field :video, Types::VideoType, null: true
    field :status, Integer, null: false

    argument :video_id, ID, required: true
    argument :input, Types::Input::VideoInput, required: true
    
    def resolve(video_id:, input:)
      Authenticate.call(context: context)
      Concepts::Videos::Repository.new.update(video_id: video_id, args: input)
      { status: 200 }
    rescue => e
      raise GraphQL::ExecutionError.new(e.message)
    end
  end
end