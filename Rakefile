# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks
require 'pact/tasks'
require 'rspec/core/rake_task'

desc "Build docker image"
task :build_image do
  sh 'docker build . -t shelf2-backend'
end

namespace :spec do
  desc "Run infrastructure tests"
  RSpec::Core::RakeTask.new(infra: :build_image) do |t|
    t.pattern = "spec/infra/*_spec.rb"
  end
end
