Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root controller: :users, action: :index
  resources :users do
    collection do
      post 'import'
      post 'download'
    end
  end
end
