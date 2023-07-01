module Concepts
  module Offers
    module Commands
      class OfferCreate < ActiveJob::Base
        extend T::Sig

        def call(event)
          id = T.must(event.data.fetch(:offer_id))
          adapter = T.must(event.data.fetch(:adapter))
          current_user_id = T.must(event.data.fetch(:current_user_id))
          informations = T.must(event.data.fetch(:informations))
          args = informations.merge({id: id, author: current_user_id})
          adapter.create(args)
        end
      end
    end
  end
end
