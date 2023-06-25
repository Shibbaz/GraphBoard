module Concepts
    module Offers
        module Commands
            class OfferCreate < ActiveJob::Base
                def call(event)
                    id = event.data.fetch(:id)
                    adapter = event.data.fetch(:adapter)
                    informations = event.data.fetch(:informations)
                    adapter.create(args)
                end
            end
        end
    end
end