require 'rails_helper'

describe User, type: :model do
  describe 'password' do
    let(:user) { build(:user) }

    it 'is hashed before save' do
      user.save!
      expect(user.reload.checksum).not_to be_empty
    end

    it 'is removed from plaintext' do
      user.save!
      expect(user.reload.password).to be nil
    end
  end

  describe '#auth?' do
    let(:password) { 'duderino' }
    let(:user) { create(:user, password: password) }

    it 'returns true for the right password' do
      expect(user.auth?(password)).to be true
    end

    it 'returns false for an incorrect password' do
      expect(user.auth?('nopenope')).to be false
    end
  end
end
