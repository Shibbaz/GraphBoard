module Mutations
  class CreateOffer < Mutations::BaseMutation
    argument :informations, Types::Input::OfferInput, required: true

    field :status, Integer, null: false

    def resolve(informations: nil)
      Authenticate.call(context: context)
      Concepts::Offers::Repository.new.create(
        informations: informations,
        current_user_id: context[:current_user_id]
      )
      {status: 200}
    rescue => e
      raise GraphQL::ExecutionError.new(e.message)
    end
  end
end
