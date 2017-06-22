require 'rails_helper'

describe Rest::BooksController, type: :controller do
  render_views

  describe '#index' do
    subject { get :index, params: { format: :json } }

    before do
      create(:book, title: 'B - Item', year: 2015)
      create(:book, title: 'A - Item', year: 2014)
      create(:book, title: 'C - Item', year: 2015)
    end

    it 'returns properly' do
      subject
      expect(response).to be_ok
    end

    it 'returns a list' do
      subject
      expect(json_response!).to be_a(Array)
    end

    it 'returns all the items' do
      subject
      expect(json_response!.count).to eq(3)
    end

    it 'returns the fields of a item' do
      subject
      item = json_response!.first
      expect(item['title']).to eq('A - Item')
      expect(item['year']).to eq(2014)
    end

    it 'is sorted by title' do
      subject
      titles = json_response!.map { |item| item['title'] }
      expect(titles).to eq(titles.sort)
    end

    it 'can be filtered by year' do
      get :index, params: { format: :json, year: 2014 }
      expect(json_response!.count).to eq(1)
      expect(json_response!.first['year']).to eq(2014)
    end
  end

  describe '#years' do
    subject { get :years, params: { format: :json } }

    before do
      create(:book, year: 2011)
      create(:book, year: 2011)
      create(:book, year: 2010)
      create(:book, year: 2014)
    end

    it 'returns a sorted list of available years' do
      subject
      expect(response).to be_ok
      expect(json_response!)
        .to eq([
                 { 'year' => 2010, 'count' => 1 },
                 { 'year' => 2011, 'count' => 2 },
                 { 'year' => 2014, 'count' => 1 }
               ])
    end
  end
end
