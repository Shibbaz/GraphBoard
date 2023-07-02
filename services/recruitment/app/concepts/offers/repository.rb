module Concepts
  module Offers
    class Repository
      attr_accessor :adapter
      extend T::Sig

      sig do params(adapter: Offer).returns(T.anything) end
      def initialize(adapter: Offer)
        @adapter = adapter
      end

      sig do params(informations: T.nilable(T.any(Types::Input::OfferInput, Hash)), current_user_id: T.nilable(String))
        .returns(T.any(RailsEventStore::Client , T.class_of(ActiveRecord::RecordNotFound))) end
      def create(informations:, current_user_id:)
        raise ArgumentError.new "Please, pass params. Params not found" if informations.empty? || current_user_id.empty?
        ActiveRecord::Base.transaction do
          Events.publish({
            current_user_id: current_user_id,
            offer_id: SecureRandom.uuid,
            adapter: @adapter,
            informations: informations.to_h
          }, 
            event: OfferWasCreated, 
            event_id: SecureRandom.uuid
          )
        end
      end

      sig do params(current_user_id: T.nilable(String), offer_id: T.nilable(String), informations: T.nilable(T.any(Types::Input::OfferInput, Hash)))
        .returns(T.any(RailsEventStore::Client , T.class_of(ActiveRecord::RecordNotFound))) end
      def update(current_user_id:, offer_id:, informations:)
        offer = T.must(@adapter.find_by(id: offer_id, author: current_user_id))
        ActiveRecord::Base.transaction do
          Events.publish({
            offer: offer,
            informations: informations.to_h
          }, 
            event: OfferWasUpdated, 
            event_id: offer_id
          )
        end
      rescue TypeError
        raise ActiveRecord::RecordNotFound
      end

      sig do params(current_user_id: T.nilable(String), offer_id: T.nilable(String))
        .returns(T.any(RailsEventStore::Client , T.class_of(ActiveRecord::RecordNotFound))) end
      def delete(current_user_id:, offer_id:)
        offer = T.must(@adapter.find_by(id: offer_id, author: current_user_id))
        ActiveRecord::Base.transaction do
          Events.publish({
            offer: offer,
          }, 
            event: OfferWasDeleted, 
            event_id: offer_id
          )
        end
      rescue TypeError
        raise ActiveRecord::RecordNotFound
      end

      sig do params(current_user_id:String, offer_id:String)
        .returns(T.any(RailsEventStore::Client , T.class_of(ActiveRecord::RecordNotFound))) end
      def apply_on_job_offer(current_user_id:, offer_id:)
        offer = T.must(@adapter.find_by(id: offer_id))
        ActiveRecord::Base.transaction do
          Events.publish({
            offer: offer,
            current_user_id: current_user_id
          }, 
            event: AppliedOnJobOffer, 
            event_id: offer_id
          )
        end
      rescue TypeError
        raise ActiveRecord::RecordNotFound
      end
    end
  end
end
