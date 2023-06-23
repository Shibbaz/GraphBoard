module Types
  class VideoType < Types::BaseObject
    field :name, String, null: true
    field :description, String, null: true
    field :video_type, String, null: true
    field :rules, GraphQL::Types::JSON, null: true
    field :user, Types::UserType, null: true

    def self.resolve_reference(object, _context)
      Article.where(user_id: object[:id])
    end

    def user
      {__typename: "User", id: object[:author]}
    end
  end
end
