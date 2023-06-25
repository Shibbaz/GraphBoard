module Concepts
    module Offers
        module Commands
            class OfferCreate < ActiveJob::Base
                def call(event)
                    id = event.fetch(:id)
                    adapter = event.fetch(:adapter)
                    informations = event.fetch(:informations)
                    args = informations.merge({id: id})
                    adapter.create(args)
                end
            end
        end
    end
end