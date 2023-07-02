module Mutations
  class DeleteOffer < Mutations::BaseMutation
    field :status, Integer, null: false
    argument :offer_id, ID, required: true

    def resolve(offer_id: nil)
      Authenticate.call(context: context)
      Concepts::Offers::Repository.new.delete(
        current_user_id: context[:current_user_id],
        offer_id: offer_id
      )
      {status: 200}
    rescue => e
      GraphQL::ExecutionError.new(e.message)
    end
  end
end
