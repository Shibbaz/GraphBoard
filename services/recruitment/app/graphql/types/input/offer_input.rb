module Types
  module Input
    class OfferInput < Types::BaseInputObject
      argument :name, String, required: true
      argument :description, String, required: true
      argument :requirements, [GraphQL::Types::JSON], required: true
      argument :tags, [ID], required: true
      argument :contact_details, [GraphQL::Types::JSON], required: true
    end
  end
end
