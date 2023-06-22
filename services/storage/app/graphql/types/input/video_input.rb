module Types
  module Input
    class VideoInput < Types::BaseInputObject
      argument :title, String, required: true
      argument :description, String, required: true
      argument :video_type, String, required: true
      argument :author, [ID], required: true
      argument :rules, [GraphQL::Types::JSON], required: false
    end
  end
end