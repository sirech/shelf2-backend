require 'rails_helper'

describe Rest::LoginsController, type: :controller do
  render_views

  describe '#create' do
    subject { post :create, params: { user: user.name, password: password, format: :json } }

    let!(:user) { create(:user, password: password) }
    let(:password) { 'trololol' }

    context 'successful' do
      it 'returns 200' do
        subject
        expect(response).to be_ok
      end

      it 'returns a token' do
        subject
        expect(json_response!['auth_token']).to be_a String
      end
    end

    context 'failed' do
      before { User.delete_all }

      it 'returns 401' do
        subject
        expect(response.status).to be 401
      end
    end
  end
end
