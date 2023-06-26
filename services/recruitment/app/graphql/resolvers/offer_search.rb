module Resolvers
  class OfferSearch < Resolvers::BaseSearchResolver
    include GraphQL::FragmentCache::ObjectHelpers
    type [Types::OfferType], null: false
    description "Lists offers"

    scope {
      Authenticate.call(context: context)
      Offer.all.load_async
    }

    option(:name, type: String) { |scope, value|
      cache_fragment(context: context, expires_in: 5.minutes) {
        scope.where name: value
      }
    }

    option(:tags, type: String) { |scope, value|
      cache_fragment(context: context, expires_in: 5.minutes) {
        scope.where tags: value
      }
    }

    def resolve
      []
    end
  end
end
