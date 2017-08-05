Rails.application.routes.draw do
  namespace 'rest' do
    resources :books, only: %i[index create] do
      collection do
        get 'years'
      end
    end
  end

  get '/', controller: 'index', action: 'index'
  get '/*rest', controller: 'index', action: 'index'
end
