module Types
  class QueryType < Types::BaseObject
		field :offers, resolver: Resolvers::OfferSearch 
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
  end
end
