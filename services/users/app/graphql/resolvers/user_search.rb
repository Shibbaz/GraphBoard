module Resolvers
  class UserSearch < Resolvers::BaseSearchResolver
    include GraphQL::FragmentCache::ObjectHelpers
    type [Types::UserType], null: false
    description "Lists users"

    scope { 
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

    option(:phone, type: Int)   { 
      |scope, value| cache_fragment(context: context, expires_in: 5.minutes) { 
        scope.where phone: value 
      }
    }

    option(:email, type: String)   { 
      |scope, value| cache_fragment(context: context, expires_in: 5.minutes) { 
        scope.where email: value 
      }
    }

    option(:description, type: String)   { 
      |scope, value| cache_fragment(context: context, expires_in: 5.minutes) { 
        scope.where description: value 
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
    option(:birthday, type: GraphQL::Types::ISO8601DateTime)   {
      |scope, value| cache_fragment(context: context, expires_in: 5.minutes) { 
        scope.where birthday: value 
      }
    }
  
    def resolve
      []
    end

  end
end