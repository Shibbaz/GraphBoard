module Concepts
  module Tags
    module Commands
      class TagCreate < ActiveJob::Base
        extend T::Sig
        
        def call(event)
          id = T.must(event.data.fetch(:tag_id))
          adapter = T.must(event.data.fetch(:adapter))
          informations = T.must(event.data.fetch(:informations))
          args = informations.merge({id: id})
          adapter.create(args)
        end
      end
    end
  end
end
