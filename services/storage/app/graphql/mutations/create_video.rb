module Mutations
  class CreateVideo < Mutations::BaseMutation
    argument :input, Types::Input::VideoInput, required: true
  
    field :status, Integer, null: false
    def resolve(input:)
      Concepts::Users::Repository.new.create(
        args: input
      )
      { status: 200}
    rescue => e
      raise GraphQL::ExecutionError.new(e.message)
    end
  end
end
