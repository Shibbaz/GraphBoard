module Types
  class UserType < Types::BaseObject
    field :name, String, null: true
    field :surname, String, null: true
    field :phone, Int, null: true
    field :email, String, null: true
    field :description, String, null: true
    field :technologies, GraphQL::Types::JSON, null: true
    field :birthday, String, null: true

    def birthday
        object.birthday.strftime("%d/%m/%Y")
    end
  end
end