module Concepts
  module Videos
    module Commands
      class Delete < ActiveJob::Base
        def call(event)
          adapter = event.data.fetch(:adapter)
          id = event.data.fetch(:video_id)
          video = adapter.find(id)
          video.destroy!
          Storage::Delete.call(
            storage: Rails.configuration.s3,
            bucket: Rails.application.credentials.config[:S3_BUCKET],
            key: id
          )
        end
      end
    end
  end
end
