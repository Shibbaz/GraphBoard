module Types
  class QueryType < Types::BaseObject
		field :users, resolver: Resolvers::UserSearch 
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
  end
end
