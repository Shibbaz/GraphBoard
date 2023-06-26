module Resolvers
  class UserSearch < Resolvers::BaseSearchResolver
    include GraphQL::FragmentCache::ObjectHelpers
    type [Types::UserType], null: false
    description "Lists users"

    scope {
      Authenticate.call(context: context)
      User.all.load_async
    }
  
    option(:name, type: String)   { 
      |scope, value| cache_fragment(context: context, expires_in: 5.minutes) { 
        scope.where name: value
        }
    }

    option(:surname, type: String)   { 
      |scope, value| cache_fragment(context: context, expires_in: 5.minutes) { 
        scope.where surname: value 
      }
    }
    
    option(:technologies, type: [String]) { 
        |scope, value| cache_fragment(context: context, expires_in: 5.minutes) { 
          scope.select{|user| user.technologies.any? {
            |h| value.include? h["name"]
          }
        }
      }
    }
  
    def resolve
      []
    end

  end
end