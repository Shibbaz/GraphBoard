module Types
    class MutationType < Types::BaseObject
		field :delete_user, mutation: Mutations::DeleteUser
		field :create_user, mutation: Mutations::CreateUser
		field :update_user, mutation: Mutations::UpdateUser
    field :sign_in_user, mutation: Mutations::SignInUser
    end
  end