require 'rails_helper'

describe Rest::SystemsController, type: :controller do
  render_views

  describe '#healthcheck' do
    subject { get :healthcheck }

    before do
      create(:book, title: 'B - Item', year: 2015)
      create(:book, title: 'A - Item', year: 2014)
      create(:book, title: 'C - Item', year: 2015)
    end

    it 'returns properly' do
      subject
      expect(response).to be_ok
    end
  end
end
