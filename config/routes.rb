Rails.application.routes.draw do
  # Sessions (login/logout)
  resource :session, only: [:new, :create, :destroy], path_names: { new: 'login' }

  # Racine du site
  root to: 'static_pages#home'

  # Gossips avec commentaires et likes imbriqués
  resources :gossips do
    resources :comments, only: [:new, :create, :edit, :update, :destroy] do
      resources :likes, only: [:create, :destroy]
    end
    resources :likes, only: [:create, :destroy]
  end

  # Autres ressources
  resources :users
  resources :cities, only: [:show]
  resources :tags, only: [:show]

  # Messages privés
  resources :messages, only: [:index, :new, :create, :show, :destroy] do
    collection do
      get :sent
    end
  end

  # Pages statiques
  get '/team',    to: 'static_pages#team',    as: :team
  get '/contact', to: 'static_pages#contact', as: :contact
  get 'welcome(/:first_name)', to: 'static_pages#welcome', as: :welcome

  # Health check
  get "up", to: "rails/health#show", as: :rails_health_check
end
