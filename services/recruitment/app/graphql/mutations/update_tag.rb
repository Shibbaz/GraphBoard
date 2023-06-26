module Mutations
  class UpdateTag < Mutations::BaseMutation
    field :status, Integer, null: false
    argument :informations, Types::Input::TagInput, required: true
    argument :tag_id, ID, required: true

    def resolve(informations:, tag_id:)
      Authenticate.call(context: context)
      Concepts::Tags::Repository.new.update(
        tag_id: tag_id,
        informations: informations
      )
      {status: 200}
    end
  end
end
