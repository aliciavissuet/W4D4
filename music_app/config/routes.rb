Rails.application.routes.draw do
  # For redetails on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :new, :create]

  resource :session, only: [:new, :create, :destroy]

  resources :bands do
     resources :albums, only: :new
  end
  resources :albums, except: [:index, :new]
end
