ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'database_cleaner'
require 'capybara/rspec'
require 'email_spec'
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
  config.include Devise::TestHelpers, type: :controller
  config.include FormHelper, type: :feature
  config.include WaitForAjax, type: :feature
  config.order = "random"
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
    #DatabaseCleaner.strategy = :transaction
    #DatabaseCleaner.clean_with(:truncation)
  end

  # Before each spec run, just to insure consistency between specs
  #config.before(:each, :js => true) do
  #  DatabaseCleaner.strategy = :truncation
  #end
  #if Capybara.current_driver == :rack_test
  #  DatabaseCleaner.strategy = :transaction
  #else
  #  DatabaseCleaner.strategy = :truncation
  #end
  config.before(:each) do
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
    else
      DatabaseCleaner.strategy = :truncation
    end
    DatabaseCleaner.start
  end

  # After each spec run, just to insure consistency between specs
  config.after(:each) do
    DatabaseCleaner.clean
    Apartment::Tenant.reset
    drop_schemas
    Capybara.app_host = 'http://example.com'
    reset_mailer
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

Capybara.configure do |config|
  config.javascript_driver = :webkit
  if Capybara.current_driver == :rack_test
    config.app_host = 'http://example.com'
  elsif
    config.app_host = 'http://lvh.me:3000'
  end
end

Capybara::Webkit.configure do |config|
  config.allow_url("http://lvh.me:3000")
  config.allow_url("http://*.lvh.me:3000")
end

