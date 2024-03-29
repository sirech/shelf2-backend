ENV['RAILS_ENV'] = 'test' unless ENV['RAILS_ENV']
require File.expand_path('../config/environment', __dir__)
require 'spec_helper'

ActiveRecord::Migration.maintain_test_schema!

require 'rspec/rails'
require 'database_cleaner'
require 'factory_girl_rails'

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
