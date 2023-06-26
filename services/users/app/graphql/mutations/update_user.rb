module Mutations
  class UpdateUser < Mutations::BaseMutation
    field :status, Integer, null: false
    argument :attributes, Types::Input::UserInput, required: true
    
    def resolve(attributes:)
      Authenticate.call(context: context)
      Concepts::Users::Repository.new.update(current_user: context[:current_user], args: attributes.to_h)
      { status: 200 }
    end
  end
end