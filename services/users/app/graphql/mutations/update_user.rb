module Mutations
  class UpdateUser < Mutations::BaseMutation
    field :status, Integer, null: false
    argument :attributes, Types::Input::UserInput, required: true
    
    sig do params(attributes: T.nilable(Hash)).returns(T.anything) end
    def resolve(attributes:)
      Authenticate.call(context: context)
      Concepts::Users::Repository.new.update(current_user: context[:current_user], args: attributes.to_h)
      { status: 200 }
    end
  end
end