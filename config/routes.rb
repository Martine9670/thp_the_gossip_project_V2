Rails.application.routes.draw do

  root to: 'static_pages#home'

  resources :gossips
  resources :users

  get "up" => "rails/health#show", as: :rails_health_check
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  get 'welcome/:first_name', to: 'static_pages#welcome', as: 'welcome'

end
