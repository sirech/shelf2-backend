# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

unless Rails.env.production?
  require 'pact/tasks'
  require 'rspec/core/rake_task'

  namespace :spec do
    desc "Build docker image"
    task :build_image do
      sh 'docker build . -t shelf2-backend'
    end

    desc "Run all tests"
    RSpec::Core::RakeTask.new(:all) do |t|
      t.exclude_pattern = 'spec/infra/*_spec.rb'
    end

    desc "Run infrastructure tests"
    RSpec::Core::RakeTask.new(infra: 'spec:build_image') do |t|
      t.pattern = 'spec/infra/*_spec.rb'
    end

    task default: :all
  end
end
