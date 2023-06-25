module Concepts
    module Tags
        module Commands
            class TagDelete < ActiveJob::Base
                def call(event)
                    offer = event.data.fetch(:tag)
                    offer.destroy!
                end
            end
        end
    end
end