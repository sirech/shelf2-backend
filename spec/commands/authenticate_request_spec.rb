require 'rails_helper'

require 'ostruct'

describe AuthenticateRequest, type: :model do
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }
  let(:token) { 'truuuuuump' }

  describe '#call' do
    subject { described_class.new(headers).call }

    it 'identifies the user' do
      receive_token(token).and_return(OpenStruct.new email: 'sirech@yahoo.com')
      expect(subject).to be_success
    end

    it 'fails if there is no authorization header' do
      headers.delete('Authorization')
      expect(subject).to be_failure
    end

    it 'fails if the user is not recognized' do
      receive_token(token).and_return(OpenStruct.new email: 'johndude@yahoo.com')
      expect(subject).to be_failure
    end

    private

    def receive_token(token)
      allow_any_instance_of(Google::Apis::Oauth2V2::Oauth2Service).to receive(:tokeninfo).with(access_token: token)
    end
  end
end
