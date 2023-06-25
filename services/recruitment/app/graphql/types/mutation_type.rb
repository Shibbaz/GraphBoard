module Types
    class MutationType < Types::BaseObject
		  field :delete_offer, mutation: Mutations::DeleteOffer
		  field :create_offer, mutation: Mutations::CreateOffer
		  field :update_offer, mutation: Mutations::UpdateOffer
    end
end