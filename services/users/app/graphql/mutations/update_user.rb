module Mutations
  class UpdateUser < Mutations::BaseMutation
    field :user, Types::UserType, null: true

    argument :attributes, Types::Input::UserInput, required: true
    
    def resolve(attributes:)
      Authenticate.call(context: context)
      Concepts::Users::Repository.new.update(current_user: context[:current_user], args: attributes.to_h)
    end
  end
end