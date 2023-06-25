module Mutations
  class CreateOffer < Mutations::BaseMutation
    argument :informations, Types::Input::OfferInput, required: true
  
    field :status, Integer, null: false
    def resolve(informations: nil)
      Concepts::Offers::Repository.new.create(
        informations: informations,
      )
      { status: 200}
    rescue => e
      raise GraphQL::ExecutionError.new(e.message)
    end
  end
end
