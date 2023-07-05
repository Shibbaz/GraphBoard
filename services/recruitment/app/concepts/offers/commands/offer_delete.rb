module Concepts
  module Offers
    module Commands
      class OfferDelete < ActiveJob::Base
        extend T::Sig
        
        def call(event)
          offer = T.must(event.data.fetch(:offer))
          offer.destroy!
        end
      end
    end
  end
end
