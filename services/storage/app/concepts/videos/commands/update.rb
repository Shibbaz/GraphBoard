module Concepts
  module Videos
    module Commands
      class Update < ActiveJob::Base
        def call(event)
          id = event.data.fetch(:video_id)
          adapter = event.data.fetch(:adapter)
          input = event.data.fetch(:args)
          video = adapter.find(id)
          raise ActiveRecord::RecordNotFound unless video
          video.update!(input)
        end
      end
    end
  end
end
