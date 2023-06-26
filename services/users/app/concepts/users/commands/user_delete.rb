module Concepts
    module Users
        module Commands
            class UserDelete < ActiveJob::Base
                def call(event)
                    event.data.fetch(:current_user).destroy!
                end
            end
        end
    end
end