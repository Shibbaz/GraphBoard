#typed: true

module Concepts
    module Users
        class Repository
            attr_accessor :adapter
            extend T::Sig

            sig do params(
              adapter: T.class_of(User)
            ).void 
            end
            def initialize(adapter: User)
                @adapter = adapter
            end

            sig do params(
                  informations: T.nilable(
                    T.any(Types::Input::UserInput, Hash)
                  ), 
                  auth_provider: T.nilable(
                    T.any(Types::Input::AuthProviderCredentialsInput, Hash)
                  )
                ).returns(T.any(RailsEventStore::Client , T.class_of(ActiveRecord::RecordNotFound))) 
            end
            def create(informations:, auth_provider:)
                T.must(informations)
                T.must(auth_provider)
                ActiveRecord::Base.transaction do
                    id = SecureRandom.uuid
                    Events.publish({
                      id: id,
                      adapter: @adapter,
                      informations: informations.to_h,
                      auth_provider: auth_provider.to_h
                    }, 
                      event: UserWasCreated, 
                      event_id: id
                    )
                end
            rescue TypeError
              raise ActiveRecord::RecordInvalid
            end

            sig do params(
                current_user: T.nilable(User),
                args: T.nilable(T.any(Types::Input::UserInput, Hash)))
              .returns(T.anything)
            end
            def update(current_user:, args:)
                T.must(current_user)
                ActiveRecord::Base.transaction do
                  Events.publish({current_user: current_user, args: args.to_h}, event: UserWasUpdated, event_id: current_user.id)
                end
            rescue TypeError
              raise ActiveRecord::RecordNotFound
            end

            sig do params(
                current_user: T.nilable(User)
              ).returns(T.anything) 
            end
            def delete(current_user:)
                T.must(current_user)
                ActiveRecord::Base.transaction do
                    Events.publish({current_user: current_user}, event: UserWasDeleted, event_id: current_user.id)
                end
            rescue TypeError
              raise ActiveRecord::RecordNotFound
            end
        end
    end
end
