module Concepts
    module Offers
        module Commands
            class OfferCreate < ActiveJob::Base
                def call(event)
                    id = event.data.fetch(:offer_id)
                    adapter = event.data.fetch(:adapter)
                    current_user_id = event.data.fetch(:current_user_id)
                    informations = event.data.fetch(:informations)
                    args = informations.merge({id: id, author: current_user_id})
                    adapter.create(args)
                end
            end
        end
    end
end