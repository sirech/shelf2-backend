require 'rails_helper'
require 'json_web_token'

describe JsonWebToken, type: :model do
  let(:payload) { { user_id: 42 } }

  describe '.encode' do
    subject { described_class.encode(payload) }

    it { is_expected.to be_a String }
  end

  describe '.decode' do
    it { expect(described_class.decode(described_class.encode(payload))).to include(user_id: 42) }

    it { expect(described_class.decode('duh')).to be nil }
  end
end
