ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'database_cleaner'
require 'capybara/rspec'
require 'email_spec'
require 'capybara/webkit'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
  config.include Devise::TestHelpers, type: :controller
  config.include FormHelper, type: :feature
  config.include WaitForAjax
  config.order = "random"
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false
  config.add_setting(:seed_tables)

  config.before(:suite) do
    #DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation, {except: config.seed_tables})
  end

  # Before each spec run, just to insure consistency between specs
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation, {except: config.seed_tables}
  end

  config.before(:each) do
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
  config.app_host = 'http://example.com'
  config.javascript_driver = :webkit
  config.always_include_port = true
end

Capybara::Webkit.configure do |config|
  # Allow a specific domain without issuing a warning.
  config.allow_url("lvh.me")

  # Wildcards are allowed in URL expressions.
  config.allow_url("*.lvh.me")
end


