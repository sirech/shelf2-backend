require 'rails_helper'
require 'json_web_token'

describe JsonWebToken, type: :model do
  let(:payload) { { user_id: 42 } }
  let(:token) { 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0Mn0.nH_lWaJCKnuIomLHd533b4CnMryq3roBWb5ql8s9RCY' }

  describe '.encode' do
    subject { described_class.encode(payload) }

    it { is_expected.to eq(token) }
  end

  describe '.decode' do
    subject { described_class.decode(token) }

    it { is_expected.to include(user_id: 42) }

    it { expect(described_class.decode('duh')).to be nil }
  end
end
