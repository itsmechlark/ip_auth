require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'rails/test_unit/railtie'

Bundler.require :default, DEVISE_ORM

begin
  require "#{DEVISE_ORM}/railtie"
rescue LoadError
end

require 'ip_auth'
require "ip_auth/orm/#{DEVISE_ORM}"

module RailsApp
  class Application < Rails::Application
    config.autoload_paths += ["#{config.root}/app/#{DEVISE_ORM}"]

    # Configure generators values. Many other options are available, be sure to check the documentation.
    # config.generators do |g|
    #   g.orm             :active_record
    #   g.template_engine :erb
    #   g.test_framework  :test_unit, fixture: true
    # end

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters << :password
    config.assets.enabled = false
  end
end
