Rails.application.routes.draw do
  namespace 'rest' do
    resources :books, only: %i[index create] do
      collection do
        get 'search/:keyword', action: 'search'
        get 'years'
      end
    end

    resource :login, only: %i[create]
  end
end
