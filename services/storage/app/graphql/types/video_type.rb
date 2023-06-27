module Types
  class VideoType < Types::BaseObject
    field :id, ID, null: true
    field :name, String, null: true
    field :description, String, null: true
    field :video_type, String, null: true
    field :rules, GraphQL::Types::JSON, null: true
    field :user, Types::UserType, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false

    def self.resolve_reference(object, _context)
      Video.where(author: object[:author])
    end

    def user
      {__typename: "User", id: object[:author]}
    end
  end
end
