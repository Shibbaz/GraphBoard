module Mutations
  class DeleteUser < Mutations::BaseMutation
    field :user, Types::UserType, null: true

    argument :id, GraphQL::Types::ID, required: true

    def resolve(id:)
      model = User.find(id)

      model.destroy
      {user: model}
    end
  end
end