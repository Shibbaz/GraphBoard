module Mutations
  class CreateVideo < Mutations::BaseMutation
    argument :informations, Types::Input::VideoInput, required: true
    argument :file, ApolloUploadServer::Upload
    field :status, Integer, null: false

    sig do params(informations: T.nilable(Hash), file: T.nilable(T.anything)).returns(T.anything) end
      def resolve(informations:, file:)
      Authenticate.call(context: context)
      Concepts::Videos::Repository.new.create(
        args: informations,
        file: file
      )
      {status: 200}
    rescue => e
      raise GraphQL::ExecutionError.new(e.message)
    end
  end
end
