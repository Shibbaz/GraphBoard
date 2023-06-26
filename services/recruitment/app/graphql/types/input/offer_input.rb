module Types
  module Input
    class OfferInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :description, String, required: false
      argument :requirements, [GraphQL::Types::JSON], required: false
      argument :tags, [ID], required: false
      argument :contact_details, [GraphQL::Types::JSON], required: false
    end
  end
end
