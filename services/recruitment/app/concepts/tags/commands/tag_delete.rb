module Concepts
  module Tags
    module Commands
      class TagDelete < ActiveJob::Base
        extend T::Sig
        
        def call(event)
          offer = T.must(event.data.fetch(:tag))
          offer.destroy!
        end
      end
    end
  end
end
