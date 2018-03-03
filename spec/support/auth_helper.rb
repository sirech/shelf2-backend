require 'ostruct'
require 'google/apis/oauth2_v2'

module AuthHelper
  def can_authenticate_with(token)
    allow_any_instance_of(::Google::Apis::Oauth2V2::Oauth2Service).to receive(:tokeninfo).with(access_token: token).and_return(OpenStruct.new email: 'sirech@yahoo.com')
  end
end

RSpec.configure do |c|
  c.include AuthHelper
end
