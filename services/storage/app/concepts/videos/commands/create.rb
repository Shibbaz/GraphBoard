module Concepts
    module Videos
        module Commands
            class Create < ActiveJob::Base
                def call(event)
                    args = event.data.fetch(:args)
                    adapter = event.data.fetch(:adapter)
                    video = adapter.create!(args)
                    Services::Storage::Upload.call(
                        storage: Rails.configuration.s3,
                        bucket: ENV['S3_BUCKET'],
                        key: file_key,
                        file: args[:file]
                    )
                end
            end
        end
    end
end