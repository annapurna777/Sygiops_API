require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require 'net/ldap'
# require "sprockets/railtie"
require "rails/test_unit/railtie"
include ActiveSupport

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SygiopsApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false
    config.add_autoload_paths_to_load_path = true
    config.api_only = true
    config.active_job.queue_adapter = :delayed_job

    config.autoload_paths += %W[#{config.root}/engines/sygiops_support/lib/sygiops_support]
    config.eager_load_paths += %W[#{config.root}/engines/sygiops_support/lib/sygiops_support]

    # config.middleware.insert_before 0, "Rack::Cors" do
    #   allow do
    #     origins 'http://127.0.0.1:4041/'
    #     resource(
    #       '*',
    #       headers: :any,
    #       methods: [:get, :patch, :put, :delete, :post, :options]
    #       )
    #   end
    # end

  end
end
