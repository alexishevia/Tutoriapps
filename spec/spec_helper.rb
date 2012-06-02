require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] ||= 'test'

Spork.prefork do
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'email_spec'
  require 'rspec/autorun'
  require 'ruby-debug'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:all) do 
      DatabaseCleaner.clean_with :truncation      
    end

    config.after(:all) do 
      DatabaseCleaner.clean_with :truncation      
    end

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)
  end
end

Spork.each_run do
  load "#{Rails.root}/config/routes.rb"
  I18n.reload!
  Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }
  require 'factory_girl_rails'
end