module Mutations
  class UpdateTag < Mutations::BaseMutation
    field :tag, Types::TagType, null: true
    argument :informations, Types::Input::TagInput, required: true
    argument :tag_id, ID, required: true

    def resolve(informations:, tag_id:)
      Authenticate.call(context: context)
      Concepts::Tags::Repository.new.update(
        current_user_id: context[:current_user_id], 
        tag_id: tag_id, 
        informations: informations
        )
    end
  end
end