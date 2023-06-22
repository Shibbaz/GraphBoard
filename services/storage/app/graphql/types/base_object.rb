module Types
  class BaseObject < GraphQL::Schema::Object
    include ApolloFederation::Object
    include GraphQL::FragmentCache::ObjectHelpers
    include GraphQL::FragmentCache::Object
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    field_class Types::BaseField
    underscore_reference_keys true
    shareable
  end
end
