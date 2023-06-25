module Types
    class MutationType < Types::BaseObject
		  field :delete_offer, mutation: Mutations::DeleteOffer
		  field :create_offer, mutation: Mutations::CreateOffer
		  field :update_offer, mutation: Mutations::UpdateOffer
		  field :delete_tag, mutation: Mutations::DeleteTag
		  field :create_tag, mutation: Mutations::CreateTag
		  field :update_tag, mutation: Mutations::UpdateTag
		  field :apply_on_job_offer, mutation: Mutations::ApplyOnJobOffer
    end
end