module Concepts
  module Tags
    class Repository
      attr_accessor :adapter
      extend T::Sig

      sig do params(adapter: TechnologyTag).returns(T.anything) end
        def initialize(adapter: TechnologyTag)
        @adapter = adapter
      end

      sig do params(informations: T.any(Types::Input::TagInput, NilClass, Hash)
        ).returns(RailsEventStore::Client || ArgumentError) 
      end
      def create(informations:)
        raise ArgumentError.new "Please, pass params. Params not found" if informations.empty?
        ActiveRecord::Base.transaction do
          tag_id = SecureRandom.uuid
          Rails.configuration.event_store.publish(
            TagWasCreated.new(
              data: {
                tag_id: tag_id,
                adapter: @adapter,
                informations: informations.to_h
              }
            ),
            stream_name: "Tags-#{tag_id}"
          )
        end
      end

      sig do params(
          tag_id: String,
          informations: T.any(Types::Input::TagInput, NilClass, Hash)
        ).returns(RailsEventStore::Client || ArgumentError) 
      end
      def update(tag_id:, informations:)
        tag = T.must(@adapter.find_by(id: tag_id))
        ActiveRecord::Base.transaction do
          Rails.configuration.event_store.publish(
            TagWasUpdated.new(data: {
              tag: tag,
              informations: informations.to_h
            }),
            stream_name: "Tags-#{tag_id}"
          )
        end
      rescue TypeError
        raise ActiveRecord::RecordNotFound
      end

      sig do params(
          tag_id: String
        ).returns(RailsEventStore::Client || ArgumentError) 
      end
      def delete(tag_id:)
        tag = T.must(@adapter.find_by(id: tag_id))
        ActiveRecord::Base.transaction do
          Rails.configuration.event_store.publish(
            TagWasDeleted.new(data: {
              tag: tag
            }),
            stream_name: "Tag-#{tag_id}"
          )
        end
      rescue TypeError
        raise ActiveRecord::RecordNotFound
      end
    end
  end
end
