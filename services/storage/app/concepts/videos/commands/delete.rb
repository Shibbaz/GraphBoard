module Concepts
  module Videos
    module Commands
      class Delete < ActiveJob::Base
        extend T::Sig

        def call(event)
          video = T.must(event.data.fetch(:video))
          video.destroy!
          Storage::Delete.call(
            storage: Rails.configuration.s3,
            bucket: Rails.application.credentials.config[:S3_BUCKET],
            key: video.id
          )
        end
      end
    end
  end
end
