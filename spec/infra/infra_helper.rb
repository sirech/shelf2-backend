require 'serverspec'
require 'docker'

require 'rspec/wait'

set :backend, :docker
set :os, family: :alpine

RSpec.configure do |config|
  config.wait_timeout = 15 # seconds

  # rubocop:disable RSpec/BeforeAfterAll
  config.before(:all) do
    image = Docker::Image.build_from_dir('.')
    set :docker_image, image.id
  end
  # rubocop:enable RSpec/BeforeAfterAll
end
