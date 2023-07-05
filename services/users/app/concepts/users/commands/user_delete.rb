#typed: true

module Concepts
    module Users
        module Commands
            class UserDelete < ActiveJob::Base
                extend T::Sig
                
                def call(event)
                    current_user = T.must(event.data.fetch(:current_user))
                    current_user.destroy!
                end
            end
        end
    end
end