require_relative 'infra_helper'

describe 'Docker Image' do
  describe file('/etc/alpine-release') do
    it { is_expected.to be_file }
    its(:content) { is_expected.to match(/3\.4\.6/) }
  end

  describe file('/app') do
    it { is_expected.to be_owned_by('app') }
  end

  describe command('ruby --version') do
    its(:stdout) { is_expected.to match(/2.4.2/) }
  end

  describe process('ruby') do
    it { is_expected.to be_running }

    its(:user) { is_expected.to eq('app') }
    its(:args) { is_expected.to match(/rails s -b 0.0.0.0/) }
  end

  it { wait_for(port(3000)).to be_listening.with('tcp') }
end
