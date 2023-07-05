module Types
  class UserType < Types::BaseObject
    key fields: ["id"]
    extend_type
    field :id, ID, null: false, external: true
    field :created_offers, [Types::OffersUserType], null: false
    field :applied_offers, [Types::OffersUserType], null: false

    def self.resolve_reference(object, _context)
      {__typename: "Offer", id: object[:id]}
    end

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
