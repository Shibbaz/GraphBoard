module Types
    class UserType < Types::BaseObject
      key fields: 'id'

      field :id, ID, null: false
      field :name, String, null: true
      field :surname, String, null: true
      field :phone, Int, null: true
      field :email, String, null: true
      field :description, String, null: true
      field :technologies, GraphQL::Types::JSON, null: true
      field :birthday, String, null: true

      def self.resolve_reference(object, _context)
        cache_fragment(context: context, expires_in: 25.minutes) { 
          RecordLoader.for(User).load(object[:id]) 
        }
      end

      def name
        cache_fragment(context: context, expires_in: 25.minutes) { object.name }
      end
  
      def surname
        cache_fragment(context: context, expires_in: 25.minutes) { object.surname }
      end
  
      def phone
        cache_fragment(context: context, expires_in: 25.minutes) { object.phone }
      end
  
      def email
        cache_fragment(context: context, expires_in: 25.minutes) { object.email }
      end
  
      def description
        cache_fragment(context: context, expires_in: 25.minutes) { object.description }
      end
  
      def technologies
        cache_fragment(context: context, expires_in: 25.minutes) { object.technologies }
      end
  
      def birthday
        cache_fragment(context: context, expires_in: 25.minutes) { object.birthday.strftime("%d/%m/%Y")}
      end
    end
  end