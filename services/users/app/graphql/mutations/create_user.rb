module Mutations
  class CreateUser < Mutations::BaseMutation
    argument :auth_provider, Types::Input::AuthProviderCredentialsInput, required: false
    argument :informations, Types::Input::UserInput, required: true
  
    field :status, Integer, null: false
    def resolve(informations: nil, auth_provider: nil)
      Concepts::Users::Repository.new.create(
        informations: informations,
        auth_provider: auth_provider
      )
      { status: 200}
    rescue => e
      raise GraphQL::ExecutionError.new(e.message)
    end
  end
end
