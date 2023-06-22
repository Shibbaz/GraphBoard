require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Storages
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true
    config.eager_load_paths += Dir[Rails.root.join('app/concepts/**/**/**.rb')].each { |rb| require rb }
    config.eager_load_paths += Dir[Rails.root.join('app/lib/**/**.rb')].each { |rb| require rb }
  end
end
