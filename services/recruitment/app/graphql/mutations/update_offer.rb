module Mutations
  class UpdateOffer < Mutations::BaseMutation
    field :offer, Types::OfferType, null: true

    argument :informations, Types::Input::OfferInput, required: true
    argument :offer_id, ID, required: true

    def resolve(informations:, offer_id:)
      Authenticate.call(context: context)
      Concepts::Offers::Repository.new.update(
        current_user_id: context[:current_user_id], 
        offer_id: offer_id, 
        informations: informations
        )
    end
  end
end