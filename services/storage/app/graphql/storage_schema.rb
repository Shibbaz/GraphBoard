class StorageSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
  include ApolloFederation::Schema
  federation version: '3.8'

  orphan_types Types::UserType

  use ApolloFederation::Tracing

  use GraphQL::Dataloader

  def self.type_error(err, context)
    super
  end

  def self.resolve_type(abstract_type, obj, ctx)
    raise(GraphQL::RequiredImplementationMissingError)
  end

  validate_max_errors(100)


  def self.id_from_object(object, type_definition, query_ctx)
    object.to_gid_param
  end

  def self.object_from_id(global_id, query_ctx)
    GlobalID.find(global_id)
  end
end
