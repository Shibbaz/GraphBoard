module Concepts
    module Offers
        module Commands
            class ApplyOnJobOffer < ActiveJob::Base
                def call(event)
                    current_user_id = event.data.fetch(:current_user_id)
                    offer = event.data.fetch(:offer)
                    offer.candidates = offer.candidates.concat([current_user_id])
                    offer.candidates = offer.candidates.uniq
                    offer.save!
                end
            end
        end
    end
end