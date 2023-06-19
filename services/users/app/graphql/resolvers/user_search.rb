module Resolvers
  class UserSearch < Resolvers::BaseSearchResolver
    type [Types::UserType], null: false
    description "Lists users"

    scope { User.all }
  
    option(:name, type: String)   { |scope, value| scope.where name: value }
    option(:surname, type: String)   { |scope, value| scope.where surname: value }
    option(:phone, type: Int)   { |scope, value| scope.where phone: value }
    option(:email, type: String)   { |scope, value| scope.where email: value }
    option(:description, type: String)   { |scope, value| scope.where description: value }
    option(:technologies, type: GraphQL::Types::JSON)   { |scope, value| scope.where technologies: value }
    option(:birthday, type: GraphQL::Types::ISO8601DateTime)   { |scope, value| scope.where birthday: value }
  
    def resolve
      []
    end

  end
end