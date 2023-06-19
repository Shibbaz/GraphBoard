module Mutations
  class UpdateUser < Mutations::BaseMutation
    field :user, Types::UserType, null: true

    argument :id, GraphQL::Types::ID, required: true
    argument :attributes, Types::Input::UserInput, required: true
    
    def resolve(attributes:, id:)
      model = User.find(id)

      if model.update_attributes(attributes.to_h)
        {user: model}
      else
        model_errors!(model)
      end
    end
  end
end