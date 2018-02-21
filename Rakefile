# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks
require 'pact/tasks'
require 'rspec/core/rake_task'

namespace :spec do
  desc "Run infrastructure tests"
  RSpec::Core::RakeTask.new(:infra) do |t|
    t.pattern = "spec/infra/*_spec.rb"
  end
end
