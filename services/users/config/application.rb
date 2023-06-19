require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Users
  class Application < Rails::Application
    config.load_defaults 7.0
    config.autoloader = :clasic
    config.api_only = true
    config.factory_bot.definition_file_paths +=
      [File.expand_path('../factories', __FILE__)] if defined?(FactoryBotRails)
    config.eager_load_paths += Dir[Rails.root.join('app/concepts/**/**/**.rb')].each { |rb| require rb }
    config.eager_load_paths += Dir[Rails.root.join('app/lib/**.rb')].each { |rb| require rb }
  end
end
