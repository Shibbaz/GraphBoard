module Concepts
  module Videos
    module Commands
      class Create
        def call(event)
          args = event.data.fetch(:args)
          file = event.data.fetch(:file)
          adapter = event.data.fetch(:adapter)
          id = event.data.fetch(:id)
          video = adapter.create!(
            id: id,
            name: args[:name],
            description: args[:description],
            video_type: args[:video_type],
            author: args[:author],
            rules: args[:rules]
          )
          Storage::Upload.call(
            storage: Rails.configuration.s3,
            bucket: Rails.application.credentials.config[:S3_BUCKET],
            key: video.id,
            file: file
          )
        end
      end
    end
  end
end
