#typed: true

module Concepts
    module Users
        module Commands
            class UserUpdate < ActiveJob::Base
                extend T::Sig

                def call(event)
                    current_user = T.must(event.data.fetch(:current_user))
                    args = T.must(event.data.fetch(:args))
                    current_user.update!(args)
                end
            end
        end
    end
end