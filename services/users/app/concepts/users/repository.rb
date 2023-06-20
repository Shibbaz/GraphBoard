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

            def update(current_user:, args:)
                raise ActiveRecord::RecordNotFound unless current_user
                ActiveRecord::Base.transaction do
                    Rails.configuration.event_store.publish(
                      UserWasUpdated.new(data:{
                        current_user: current_user,
                        args: args.to_h
                      }),
                      stream_name: "User-#{current_user.id}"
                    )
                end
            end

            def delete(current_user:)
                raise ActiveRecord::RecordNotFound unless current_user
                ActiveRecord::Base.transaction do
                    Rails.configuration.event_store.publish(
                      UserWasDeleted.new(data:{
                        current_user: current_user
                      }),
                      stream_name: "User-#{current_user.id}"
                    )
                end
            end
        end
    end
end

