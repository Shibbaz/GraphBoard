#typed: true

module Concepts
    module Users
        module Commands
            class UserCreate < ActiveJob::Base
                extend T::Sig

                def call(event)
                    informations = T.must(event.data.fetch(:informations))
                    auth_provider = T.must(event.data.fetch(:auth_provider))
                    adapter = T.must(event.data.fetch(:adapter))
                    id = T.must(event.data.fetch(:id))
                    adapter.create!(
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