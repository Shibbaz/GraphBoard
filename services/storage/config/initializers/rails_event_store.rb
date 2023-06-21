require "rails_event_store"

Rails.configuration.event_store = RailsEventStore::Client.new(
  dispatcher:
    RubyEventStore::ComposedDispatcher.new(
      RailsEventStore::AfterCommitAsyncDispatcher.new(scheduler: CustomScheduler.new),
      RubyEventStore::Dispatcher.new,
    ),
)
Rails.configuration.event_store.subscribe(Concepts::Videos::Commands::Create.new, to: [VideoWasCreated])
Rails.configuration.event_store.subscribe(Concepts::Videos::Commands::Delete.new, to: [VideoWasDeleted])
Rails.configuration.event_store.subscribe(Concepts::Videos::Commands::Update.new, to: [VideoWasUpdated])