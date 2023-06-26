module Concepts
    module Users
        module Commands
            class UserUpdate < ActiveJob::Base
                def call(event)
                    current_user = event.data.fetch(:current_user)
                    args = event.data.fetch(:args)
                    current_user.update!(args)
                end
            end
        end
    end
end