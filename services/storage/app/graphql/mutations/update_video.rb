module Mutations
  class UpdateVideo < Mutations::BaseMutation
    field :video, Types::VideoType, null: true
    field :status, Integer, null: false

    argument :video_id, ID, required: true
    argument :informations, Types::Input::VideoInput, required: true

    def resolve(**args)
      Authenticate.call(context: context)
      Concepts::Videos::Repository.new.update(video_id: args[:video_id], args: args[:informations])
      {status: 200}
    rescue => e
      raise GraphQL::ExecutionError.new(e.message)
    end
  end
end
