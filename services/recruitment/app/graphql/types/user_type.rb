module Types
  class UserType < Types::BaseObject
    key fields: ["id"]
    extend_type
    field :id, ID, null: false, external: true
    field :created_offer, Types::OfferType.connection_type, null: true
    field :applied_offers, Types::OfferType.connection_type, null: true

    def created_offers
      Offer.where(author: object[:id])
    end

    def applied_offers
      Offer.select do |offer|
        offer.candidates.include?(object[:id])
      end
    end
  end
end
