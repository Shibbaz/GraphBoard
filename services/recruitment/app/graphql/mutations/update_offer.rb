module Mutations
  class UpdateOffer < Mutations::BaseMutation
    field :offer, Types::OfferType, null: true

    argument :attributes, Types::Input::OfferInput, required: true
    
    def resolve(attributes:)
      Authenticate.call(context: context)
      Concepts::Offers::Repository.new.update(
        current_user_id: context[:current_user_id],
        args: attributes.to_h
        )
    end
  end
end