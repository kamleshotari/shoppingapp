ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'
Faker = Faker
RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.syntax = [:should, :expect]
  end
  config.mock_with :rspec do |mocks|
    mocks.syntax = [:should, :expect]
  end
  config.expose_dsl_globally = true
  config.use_transactional_fixtures = false
  config.order = "random"
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.include Devise::TestHelpers, type: :controller
  config.include FactoryGirl::Syntax::Methods
  config.before do
    FactoryGirl.find_definitions
  end
end
