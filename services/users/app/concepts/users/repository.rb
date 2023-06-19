module Concepts
    module Users
        class Repository
            attr_accessor :adapter

            def initialize(adapter: User)
                @adapter = adapter
            end

            def create(informations:, auth_provider:)
                ActiveRecord::Base.transaction do
                    id = SecureRandom.uuid
                    Rails.configuration.event_store.publish(
                      UserWasCreated.new(data:{
                        id: id,
                        informations: informations.to_h,
                        auth_provider: auth_provider.to_h
                      }),
                      stream_name: "User-#{id}"
                    )
                end
            end
        end
    end
end

