module Types
  module Input
    class UserInput < Types::BaseInputObject
      argument :name, String, required: true
      argument :surname, String, required: true
      argument :phone, Int, required: true
      argument :email, String, required: true
      argument :description, String, required: true
      argument :technologies, [GraphQL::Types::JSON], required: true
      argument :birthday, String, required: true
    end
  end
end