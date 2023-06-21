module Types
    class VideoType < Types::BaseObject

        field :id, ID, null: false
        field :name, String, null: true
        field :description, String, null: true  
        field :author, ID, null: true
        field :type, String, null: true
        field :rules, [GraphQL::Types::JSON], null: true
        field :created_at, GraphQL::Types::ISO8601DateTime, null: true
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    end
end