require 'rails_helper'

describe AuthenticateUser, type: :model do
  let(:password) { 'this is a password' }
  let!(:user) { create(:user, password: password) }

  describe '#call' do
    it 'is succesful if the user is there and the password matches' do
      expect(described_class.call(user.name, password)).to be_success
    end

    it 'fails if the wrong password is used' do
      expect(described_class.call(user.name, 'dudedude')).to be_failure
    end

    it 'fails if the user does not exist' do
      expect(described_class.call('john.dude', password)).to be_failure
    end
  end
end
