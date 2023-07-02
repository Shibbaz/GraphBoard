class Events
    def self.publish(args, event:, event_id:)
        Rails.configuration.event_store.publish(
            event.new(data: args),
            stream_name: "Video-#{T.must(event_id)}"
          )
    end
end