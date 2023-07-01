module Mutations
  class UpdateOffer < Mutations::BaseMutation
    field :status, Integer, null: false

    argument :informations, Types::Input::OfferInput, required: true
    argument :offer_id, ID, required: true

    sig do params(informations: Hash, offer_id: String).returns(T.anything) end
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
