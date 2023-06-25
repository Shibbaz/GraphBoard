require "rails_event_store"

Rails.configuration.event_store = RailsEventStore::Client.new(
  dispatcher:
    RubyEventStore::ComposedDispatcher.new(
      RailsEventStore::AfterCommitAsyncDispatcher.new(scheduler: CustomScheduler.new),
      RubyEventStore::Dispatcher.new,
    ),
)
Rails.configuration.event_store.subscribe(Concepts::Offers::Commands::OfferCreate.new, to: [OfferWasCreated])
Rails.configuration.event_store.subscribe(Concepts::Offers::Commands::OfferDelete.new, to: [OfferWasDeleted])
Rails.configuration.event_store.subscribe(Concepts::Offers::Commands::OfferUpdate.new, to: [OfferWasUpdated])