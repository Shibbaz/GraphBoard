module Types
    class VideoType < Types::BaseObject
        field :id, ID, null: false
        field :name, String, null: true
        field :description, String, null: true
        field :video_type, String, null: true
        field :rules, GraphQL::Types::JSON, null: true
    end
end
