module Types
  module Input
    class UpdateUserInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :surname, String, required: false
      argument :phone, Int, required: false
      argument :email, String, required: false
      argument :description, String, required: false
      argument :technologies, [GraphQL::Types::JSON], required: false
      argument :birthday, String, required: false
    end
  end
end