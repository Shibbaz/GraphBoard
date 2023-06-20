module Resolvers
  class BaseSearchResolver < GraphQL::Schema::Resolver
    include GraphQL::FragmentCache::ObjectHelpers
    require 'search_object'
    require 'search_object/plugin/graphql'
    include SearchObject.module(:graphql)
  end
end