source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rake'
gem 'rails', '~> 7.0'
gem 'bootsnap', require: false

gem 'simple_command'

group :ops do
  # Use Puma as the app server
  gem 'puma', '~> 5.0'

  gem 'mysql2'
  gem 'jwt'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'factory_bot_rails', require: false
  gem 'faker'
end

group :development do
  gem 'listen'
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Linters
  gem 'overcommit'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'

  gem 'coveralls', require: false
end

group :test do
  gem 'database_cleaner', require: false
  gem 'rspec-rails'
  gem 'pact'

  gem 'docker-api'
  gem 'rspec-wait'
  gem 'serverspec', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Fixing error with bundle install
gem "nio4r", ">= 2.6.0"

# Fixing CRL errors
gem "openssl", "~> 3.3.1"

# FIXME:
# mail v2.8.0 shipped with faulty file permissions, see: https://github.com/mikel/mail/issues/1489.
# Remove the following line once a fixed release is available:
gem 'mail', '!= 2.8.0'
