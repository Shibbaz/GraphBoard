module Concepts
  module Videos
    module Commands
      class Create
        extend T::Sig

        def call(event)
          args = T.must(event.data.fetch(:args))
          file = T.must(event.data.fetch(:file))
          adapter = T.must(event.data.fetch(:adapter))
          id = T.must(event.data.fetch(:id))
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
