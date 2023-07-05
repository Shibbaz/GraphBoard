module Concepts
  module Offers
    module Commands
      
      class ApplyOnJobOffer < ActiveJob::Base
        extend T::Sig

        def call(event)
          current_user_id = T.must(event.data.fetch(:current_user_id))
          offer = T.must(event.data.fetch(:offer))
          candidates = T.must(offer.candidates)
          offer.candidates = candidates.concat([current_user_id])
          offer.save!
        end
      end
    end
  end
end
