module Mutations
    class SignInUser < BaseMutation  
        argument :credentials, Types::Input::AuthProviderCredentialsInput, required: false
  
        field :token, String, null: true
        field :user, Types::UserType, null: true

        def resolve(credentials: nil)
            data = Concepts::Users::Queries::SignInUser.call(credentials)
            context[:session][:token] = data[:token]
            return data
        end
    end
end