module Concepts
  module Offers
    module Commands
      class OfferUpdate < ActiveJob::Base
        extend T::Sig
        
        def call(event)
          offer = T.must(event.data.fetch(:offer))
          informations = T.must(event.data.fetch(:informations))
          offer.update(informations)
        end
      end
    end
  end
end
