module Types
  module Input
    class TagInput < Types::BaseInputObject
      argument :name, String, required: true
    end
  end
end