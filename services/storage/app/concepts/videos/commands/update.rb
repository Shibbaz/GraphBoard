module Concepts
  module Videos
    module Commands
      class Update < ActiveJob::Base
        extend T::Sig

        def call(event)
          video = T.must(event.data.fetch(:video))
          input = T.must(event.data.fetch(:args))
          video.update!(input)
        end
      end
    end
  end
end
