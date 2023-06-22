module Concepts
    module Videos
        module Commands
            class Delete < ActiveJob::Base
                def call(event)
                    adapter = event.data.fetch(:adapter)
                    id = event.data.fetch(:video_id)
                    video = adapter.find(id)
                    video.destroy!
                end
            end
        end
    end
end