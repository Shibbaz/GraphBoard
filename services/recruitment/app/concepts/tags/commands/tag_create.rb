module Concepts
    module Tags
        module Commands
            class TagCreate < ActiveJob::Base
                def call(event)
                    id = event.data.fetch(:tag_id)
                    adapter = event.data.fetch(:adapter)
                    informations = event.data.fetch(:informations)
                    args = informations.merge({id: id})
                    adapter.create(args)
                end
            end
        end
    end
end