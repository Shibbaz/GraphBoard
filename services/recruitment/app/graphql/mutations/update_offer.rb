module Mutations
  class UpdateOffer < Mutations::BaseMutation
    field :status, Integer, null: false

    argument :informations, Types::Input::UpdateOfferInput, required: true
    argument :offer_id, ID, required: true

    def resolve(informations:, offer_id:)
      Authenticate.call(context: context)
      Concepts::Offers::Repository.new.update(
        current_user_id: context[:current_user_id],
        offer_id: offer_id,
        informations: informations
      )
      {status: 200}
    end
  end
end
