module Concepts
    module Tags
        module Commands
            class TagUpdate < ActiveJob::Base
                def call(event)
                    tag = event.data.fetch(:tag)
                    informations = event.data.fetch(:informations)
                    tag.update(informations)
                end
            end
        end
    end
end