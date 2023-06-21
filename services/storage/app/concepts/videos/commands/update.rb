module Concepts
    module Videos
        module Commands
            class Update < ActiveJob::Base
                def call(event)
                    id = event.data.fetch(:id)
                    video = adapter.find(id)
                    raise ActiveRecord::RecordNotFound unless video
                    video.update!(args)
                end
            end
        end
    end
end