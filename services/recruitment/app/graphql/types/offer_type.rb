module Types
  class OfferType < Types::BaseObject
    field :name, String, null: true
    field :description, String, null: true
    field :requirements, [GraphQL::Types::JSON], null: true
    field :tags, [ID], null: true
    field :author, Types::UserType, null: true
    field :candidates, [Types::UserType], null: true

    field :contact_details, GraphQL::Types::JSON, null: true

    def author
      cache_fragment(context: context, expires_in: 25.minutes) {
        {__typename: "User", id: object[:author]}
      }
    end

    def candidates
      cnds = []
      for candidate in object[:candidates] 
        cnds = cnds << {__typename: "User", id: candidate}
      end
      cnds
    end

    def name
      cache_fragment(context: context, expires_in: 25.minutes) { object.name }
    end

    def description
      cache_fragment(context: context, expires_in: 25.minutes) { object.description }
    end

    def requirements
      cache_fragment(context: context, expires_in: 25.minutes) { object.requirements }
    end

    def tags
      cache_fragment(context: context, expires_in: 25.minutes) { object.tags }
    end

    def contact_details
      cache_fragment(context: context, expires_in: 25.minutes) { object.contact_details }
    end
  end
end
