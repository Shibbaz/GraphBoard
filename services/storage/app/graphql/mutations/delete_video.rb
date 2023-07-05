module Mutations
  class DeleteVideo < Mutations::BaseMutation
    argument :video_id, ID, required: true
    field :status, Integer, null: false

    def resolve(video_id:)
      Authenticate.call(context: context)
      Concepts::Videos::Repository.new.delete(video_id: video_id)
      {status: 200}
    rescue => e
      raise GraphQL::ExecutionError.new(e.message)
    end
  end
end
