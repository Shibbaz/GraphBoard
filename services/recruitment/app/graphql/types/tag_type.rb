module Types
  class TagType < Types::BaseObject
    field :id, ID, null: true
    field :name, String, null: true
  end
end
