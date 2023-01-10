require 'rails_helper'

describe Rest::BooksController do
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
      titles = json_response!.pluck('title')
      expect(titles).to eq(titles.sort)
    end

    it 'can be filtered by year' do
      get :index, params: { format: :json, year: 2014 }
      expect(json_response!.count).to eq(1)
      expect(json_response!.first['year']).to eq(2014)
    end
  end

  describe '#search' do
    subject { get :search, params: { keyword:, format: :json } }

    let(:keyword) { 'book' }

    it 'returns properly' do
      subject
      expect(response).to be_ok
    end

    it 'returns a list' do
      subject
      expect(json_response!).to be_a(Array)
    end

    it 'is empty if the title does not match' do
      create(:book, title: 'somehing')

      subject
      expect(json_response!.count).to eq(0)
    end

    it 'returns every book that matches the keyword' do
      create(:book, title: 'there is a book')
      create(:book, title: 'book one')
      create(:book, title: 'this book is good')

      subject
      expect(json_response!.count).to eq(3)
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

  describe '#create' do
    subject { post :create, params: { format: :json, book: attributes_for(:book) } }

    let(:book) { build(:book) }

    context 'when unauthorized' do
      it 'returns a 401' do
        subject
        expect(response).to have_http_status :unauthorized
      end
    end

    context 'when authorized' do
      let(:headers) { { 'Authorization' => "Bearer #{token}" } }
      let(:token) { 'truuump' }

      before do
        request.headers.merge! headers
        can_authenticate_with(token)
      end

      it 'returns a 201' do
        subject
        expect(response).to have_http_status :created
      end

      it 'creates a new book' do
        expect do
          subject
        end.to change(Book, :count).by(1)
      end

      it 'returns a 422 if the book is invalid' do
        post :create, params: { format: :json, book: { name: '' } }
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end
end
