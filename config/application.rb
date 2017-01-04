require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

if defined?(Bundler)
  Bundler.require(*Rails.groups)

  shared_groups = %w{
    web secure model authentication
    parsing
  }
  shared_groups.each do |group|
    Bundler.require(group)
  end
end

module SampleRails5
  class Application < Rails::Application
    Mongoid.load! './config/mongoid.yml'

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :put, :delete, :options]
      end
    end

    config.generators do |g|
      g.orm :mongoid
    end

    config.middleware.use Rack::Attack

    config.api_only = true
  end
end
