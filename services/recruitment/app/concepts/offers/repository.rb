module Concepts
    module Offers
        class Repository
            attr_accessor :adapter

            def initialize(adapter: Offer)
                @adapter = adapter
            end

            def create(informations:)
                ActiveRecord::Base.transaction do
                    id = SecureRandom.uuid
                    Rails.configuration.event_store.publish(
                      OfferWasCreated.new(
                        data: {
                          id: id,
                          adapter: @adapter,
                          informations: informations.to_h,
                        }
                      ),
                      stream_name: "Offer-#{id}"
                    )
                end
            end

            def update(current_user_id:, offer_id:, informations:)
                offer = @adapter.find_by(id: offer_id, author: current_user_id)
                raise ActiveRecord::RecordNotFound unless offer
                ActiveRecord::Base.transaction do
                    Rails.configuration.event_store.publish(
                      OfferWasUpdated.new(data:{
                        offer: offer,
                        informations: informations.to_h
                      }),
                      stream_name: "Offer-#{offer_id}"
                    )
                end
            end

            def delete(current_user_id:, offer_id:)
                offer = @adapter.find_by(id: offer_id, author: current_user_id)
                raise ActiveRecord::RecordNotFound unless offer
                ActiveRecord::Base.transaction do
                    Rails.configuration.event_store.publish(
                      UserWasDeleted.new(data:{
                        offer: offer
                      }),
                      stream_name: "Offer-#{offer_id}"
                    )
                end
            end
        end
    end
end

