module Mutations
  class DeleteTag < Mutations::BaseMutation
    field :status, Integer, null: false
    argument :tag_id, ID, required: true

    def resolve(tag_id: nil)
      Authenticate.call(context: context)
      Concepts::Tags::Repository.new.delete(
        tag_id: tag_id
      )
      {status: 200}
    rescue => e
      GraphQL::ExecutionError.new(e.message)
    end
  end
end
