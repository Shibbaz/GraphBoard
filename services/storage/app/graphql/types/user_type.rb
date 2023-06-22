module Types
    class UserType < Types::BaseObject
      key fields: ['id']
      extend_type
      field :id, ID, null: false, external: true
      field :videos, Types::VideoType.connection_type, null: true
  
      def videos
        Video.where(author: object[:id])
      end
      
    end
  end