module Mutations
  class DeleteUser < Mutations::BaseMutation
    field :status, Integer, null: false

    def resolve
      Authenticate.call(context: context)
      Concepts::Users::Repository.new.delete(current_user: context[:current_user])
      { status: 200 }
    rescue => e
      GraphQL::ExecutionError.new(e.message)
    end
  end
end