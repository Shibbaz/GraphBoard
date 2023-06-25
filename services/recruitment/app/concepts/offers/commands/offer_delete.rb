module Concepts
    module Offers
        module Commands
            class OfferDelete < ActiveJob::Base
                def call(event)
                    offer = event.fetch(:offer)
                    offer.destroy!
                end
            end
        end
    end
end