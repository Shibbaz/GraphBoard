require "rails_event_store"

Rails.configuration.event_store = RailsEventStore::Client.new(
  dispatcher:
    RubyEventStore::ComposedDispatcher.new(
      RailsEventStore::AfterCommitAsyncDispatcher.new(scheduler: CustomScheduler.new),
      RubyEventStore::Dispatcher.new,
    ),
)
Rails.configuration.event_store.subscribe(
  Concepts::Users::Commands::UserCreate.new, to: [UserWasCreated]
)
