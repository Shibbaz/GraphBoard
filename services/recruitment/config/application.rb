require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Recruitment
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true
    config.eager_load_paths += Dir[Rails.root.join("app/concepts/**/**/**.rb")].each { |rb| require rb }
    config.eager_load_paths += Dir[Rails.root.join("app/lib/**.rb")].each { |rb| require rb }
    config.session_store :cookie_store, key: "_interslice_session"
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options
    config.graphql_fragment_cache.store = :redis_cache_store, {url: ENV["REDIS_URL"]}
    GraphQL::FragmentCache.enabled = false if Rails.env.test?
  end
end
