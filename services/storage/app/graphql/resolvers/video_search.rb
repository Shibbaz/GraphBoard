module Resolvers
  class VideoSearch < Resolvers::BaseSearchResolver
    type [Types::VideoType], null: false
    description "Lists videos"

    scope {
      Authenticate.call(context: context)
      Video.all.reload
    }
    option(:name, type: String) { |scope, value| scope.where name: value }
    option(:video_type, type: String) { |scope, value| scope.where video_type: value }
    option(:created_at, type: GraphQL::Types::Boolean) { |scope, value|
      column = Video.arel_table[:created_at]
      if value == false
        scope.order(column.desc)
      else
        scope.order(column.asc)
      end
    }

    def resolve
      []
    end
  end
end
