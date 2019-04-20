require 'rails_helper'

describe AuthenticateRequest, type: :model do
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }
  let(:token) { 'truuuuuump' }

  describe '#call' do
    subject { described_class.new(headers).call }

    it 'verifies the user' do
      allow(JsonWebToken).to receive(:verify).and_return(scopes('create:books'))
      expect(subject).to be_success
    end

    it 'fails if the create:books scope is not provided' do
      allow(JsonWebToken).to receive(:verify).and_return(scopes('read:books'))
      expect(subject).to be_failure
    end

    it 'fails if there is no authorization header' do
      headers.delete('Authorization')
      expect(subject).to be_failure
    end

    it 'fails if the user is not recognized' do
      allow(JsonWebToken).to receive(:verify).and_raise(JWT::DecodeError)
      expect(subject).to be_failure
    end

    private

    def scopes(scope)
      [
        { 'scope' => scope }
      ]
    end
  end
end
