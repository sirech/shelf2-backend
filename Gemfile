source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rake'
gem 'rails', '~> 6.1.0'
gem 'bootsnap', require: false

gem 'simple_command'

group :ops do
  # Use Puma as the app server
  gem 'puma', '~> 5.3'

  gem 'mysql2'
  gem 'jwt'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'factory_girl_rails', require: false
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
