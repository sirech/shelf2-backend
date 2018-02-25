require 'serverspec'
require 'docker'

require 'rspec/wait'

set :backend, :docker
set :os, family: :alpine
set :docker_image, 'shelf2-backend'

RSpec.configure do |config|
  config.wait_timeout = 15 # seconds
end
