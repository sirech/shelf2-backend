require 'rails_helper'

describe AuthenticateRequest, type: :model do
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }
  let(:token) { JsonWebToken.encode(user_id: user.id) }
  let!(:user) { create(:user) }

  describe '#call' do
    subject { described_class.new(headers).call }

    it 'identifies the user' do
      expect(subject).to be_success
    end

    it 'fails if there is no authorization header' do
      headers.delete('Authorization')
      expect(subject).to be_failure
    end

    it 'fails if the authorization is incorrect' do
      headers['Authorization'] = 'Bearer crapfuk'
      expect(subject).to be_failure
    end
  end
end
