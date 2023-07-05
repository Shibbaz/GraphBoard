module Concepts
  module Videos
    class Repository
      attr_accessor :adapter
      extend T::Sig

      sig do params(adapter: Video).returns(T.anything) end
      def initialize(adapter: Video)
        @adapter = adapter
      end

      sig do params(
          args: T.nilable(T.any(Types::Input::VideoInput, Hash)),
          file: T.anything
        ).returns(
          T.any(RailsEventStore::Client, ArgumentError, FileInvalidTypeError)
        )
      end
      def create(args:, file:)
        raise ArgumentError if args.nil? || args == {}
        raise FileInvalidTypeError if file.nil? || File.extname(file.path) != ".mov"
        ActiveRecord::Base.transaction do
          id = SecureRandom.uuid
          Events.publish({
            id: id,
            args: args.to_h,
            file: file.tempfile,
            adapter: @adapter
          }, 
            event: VideoWasCreated, 
            event_id: id
          )
        end
      end

      sig do params(
          video_id: String, 
          args: T.any(Types::Input::VideoInput, Hash, NilClass)
        ).returns(
            T.any(RailsEventStore::Client,
            T.class_of(ActiveRecord::RecordNotFound)
          )
        ) 
      end
      def update(video_id:, args:)
        video = T.must(@adapter.find_by(id: video_id))
        ActiveRecord::Base.transaction do
          Events.publish({video: video, args: args.to_h}, event: VideoWasUpdated, event_id: video_id)
        end
      rescue TypeError
        raise ActiveRecord::RecordNotFound
      end

      sig do params(video_id: String).returns(
        T.any(RailsEventStore::Client,
        T.class_of(ActiveRecord::RecordNotFound))
      )
      end
      def delete(video_id:)
        video = T.must(@adapter.find_by(id: video_id))
        ActiveRecord::Base.transaction do
          Events.publish({video: video}, event: VideoWasDeleted, event_id: video_id)
        end
      rescue TypeError
        raise ActiveRecord::RecordNotFound
      end
    end
  end
end
