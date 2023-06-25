module Mutations
  class CreateTag < Mutations::BaseMutation
    argument :informations, Types::Input::TagInput, required: true
  
    field :status, Integer, null: false
    def resolve(informations: nil)
      Concepts::Tags::Repository.new.create(
        informations: informations,
      )
      { status: 200}
    rescue => e
      raise GraphQL::ExecutionError.new(e.message)
    end
  end
end
