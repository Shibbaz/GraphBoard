module Types
  class QueryType < Types::BaseObject
    field :videos, resolver: Resolvers::VideoSearch
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
  end
end
