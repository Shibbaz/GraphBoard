module Concepts
    module Users
        module Commands
            class UserCreate < ActiveJob::Base

                def call(event)
                    informations = event.data.fetch(:informations)
                    auth_provider = event.data.fetch(:auth_provider)
                    id = event.data.fetch(:id)
                    User.create!(
                        id: id,
                        name: informations[:name],
                        surname: informations[:surname],
                        phone: informations[:phone],
                        description: informations[:description],
                        technologies: informations[:technologies],
                        birthday: informations[:birthday],
                        email: auth_provider&.[](:email),
                        password: auth_provider&.[](:password)
                    )
                end

            end
        end
    end
end