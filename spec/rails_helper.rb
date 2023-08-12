# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'capybara/rspec'
require 'capybara/rails'

require 'selenium-webdriver'
require 'webdrivers/chromedriver'

RSpec.configure do |config|
  config.after(:each, type: :system) do
    driven_by :rack_test
    Capybara.reset_sessions!
    page.driver.reset!
  end

  config.before(:each, type: :system, js: true) do
    if ENV['SELENIUM_DRIVER_URL'].present?
      driven_by :selenium, using: :chrome,
                           options: {
                             browser: :remote,
                             url: ENV.fetch('SELENIUM_DRIVER_URL'),
                             desired_capabilities: :chrome
                           }
      Capybara.run_server = false
      Capybara.app_host = ENV.fetch('CAPYBARA_APP_HOST')
      Capybara.ignore_hidden_elements = false
      Capybara.javascript_driver = :selenium
    else
      Capybara.register_driver :headless_chrome do |app|
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_option('w3c', false)
        %w[headless window-size=1280x1280 disable-gpu].each { |arg| options.add_argument(arg) }
        Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
      end

      driven_by :headless_chrome
    end
  end

  config.before(:all, type: :system) do
    # Assets take a long time to compile. This causes two problems:
    # 1) the profile will show the first feature test taking much longer than it
    #    normally would.
    # 2) The first feature test will trigger rack-timeout
    #
    # Precompile the assets to prevent these issues.
    visit '/assets/application.css'
    visit '/assets/application.js'
  end
end