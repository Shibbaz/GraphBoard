module Concepts
    module Offers
        module Commands
            class OfferUpdate < ActiveJob::Base
                def call(event)
                    offer = event.data.fetch(:offer)
                    informations = event.data.fetch(:informations)
                    offer.update(informations)
                end
            end
        end
    end
end