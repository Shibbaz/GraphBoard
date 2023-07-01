module Concepts
  module Tags
    module Commands
      class TagUpdate < ActiveJob::Base
        extend T::Sig

        def call(event)
          tag = T.must(event.data.fetch(:tag))
          informations = T.must(event.data.fetch(:informations))
          tag.update(informations)
        end
      end
    end
  end
end
