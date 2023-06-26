module Types
  module Input
    class VideoInput < Types::BaseInputObject
      argument :name, String, required: false
      argument :description, String, required: false
      argument :video_type, String, required: false
      argument :author, ID, required: false
      argument :rules, [GraphQL::Types::JSON], required: false
    end
  end
end
