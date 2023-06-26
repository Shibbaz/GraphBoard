module Types
  class BaseArgument < GraphQL::Schema::Argument
    include ApolloFederation::Argument
  end
end
