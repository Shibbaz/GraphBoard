module Resolvers
  class VideoSearch < Resolvers::BaseSearchResolver
    type [Types::VideoType], null: false
    description "Lists videos"

    scope { Video.all }
    option(:name, type: String) { |scope, value| scope.where name: value }
    option(:description, type: String) { |scope, value| scope.where description: value }
    option(:type, type: String) { |scope, value| scope.where type: value }
    option(:rules, type: GraphQL::Types::JSON) { |scope, value| scope.where rules: value }
    option(:created_at, type: GraphQL::Types::ISO8601DateTime) { |scope, value| scope.where created_at: value }

    def resolve
      []
    end
  end
end
