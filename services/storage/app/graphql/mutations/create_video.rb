module Mutations
  class CreateVideo < Mutations::BaseMutation
    argument :input, Types::Input::VideoInput, required: true
    argument :file, ApolloUploadServer::Upload, required: true
    field :status, Integer, null: false
    def resolve(input:, file:)
      Authenticate.call(context: context)
      Concepts::Videos::Repository.new.create(
        args: input,
        file: file
      )
      {status: 200}
    rescue => e
      raise GraphQL::ExecutionError.new(e.message)
    end
  end
end
