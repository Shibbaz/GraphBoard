module Concepts
    module Videos
        class Repository
            attr_accessor :adapter

            def initialize(adapter: Video)
                @adapter = adapter
            end

            def create(args:)
                ActiveRecord::Base.transaction do
                    id = SecureRandom.uuid
                    Rails.configuration.event_store.publish(
                      VideoWasCreated.new(data:{
                        id: id,
                        args: args.to_h,
                        adapter: adapter
                      }),
                      stream_name: "Video-#{id}"
                    )
                end
            end

            def update(video_id:, args:)
                ActiveRecord::Base.transaction do
                    Rails.configuration.event_store.publish(
                      VideoWasUpdated.new(data:{
                        adapter: adapter,
                        video_id: video_id,
                        args: args.to_h
                      }),
                      stream_name: "Video-#{current_user.id}"
                    )
                end
            end

            def delete(video_id:)
                ActiveRecord::Base.transaction do
                    Rails.configuration.event_store.publish(
                      VideoWasDeleted.new(data:{
                        video_id: video_id,
                        adapter: adapter
                      }),
                      stream_name: "Video-#{current_user.id}"
                    )
                end
            end
        end
    end
end

