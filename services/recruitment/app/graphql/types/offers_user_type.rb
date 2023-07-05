module Types
    class OffersUserType < Types::BaseObject
      field :id, ID, null: true
      field :name, String, null: true
      field :surname, String, null: true
      field :phone, Integer, null: true
      field :technologies, [GraphQL::Types::JSON], null: true
    end
end
  