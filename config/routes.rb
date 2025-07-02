Rails.application.routes.draw do
  # Définit la route racine du site ("/") qui pointe vers l'action 'home' du contrôleur StaticPages
  root to: 'static_pages#home'

  # Génère automatiquement toutes les routes REST (index, show, new, create, edit, update, destroy) pour les potins
  resources :gossips

  # Génère automatiquement toutes les routes REST pour les utilisateurs
  resources :users

  # Route système de Rails pour vérifier l’état de santé de l’application (utile pour le déploiement)
  # Accessible via GET /up
  get "up" => "rails/health#show", as: :rails_health_check

  # Route personnalisée pour la page de l’équipe : GET /team => static_pages#team
  get '/team', to: 'static_pages#team'

  # Route personnalisée pour la page de contact : GET /contact => static_pages#contact
  get '/contact', to: 'static_pages#contact'

  # Route dynamique pour afficher une page de bienvenue personnalisée avec le prénom passé dans l’URL
  # Exemple : /welcome/Julie => static_pages#welcome avec params[:first_name] = "Julie"
  # La route est nommée : 'welcome' (utilisable via welcome_path("Julie"))
  get 'welcome/:first_name', to: 'static_pages#welcome', as: 'welcome'
end

