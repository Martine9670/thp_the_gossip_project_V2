class StaticPagesController < ApplicationController

  # Action pour la page d'accueil
  def home
    # Récupère tous les potins en incluant les utilisateurs associés pour optimiser les requêtes
    @gossips = Gossip.all.includes(:user)
  end

  # Action pour la page "team" (équipe) - probablement une page statique
  def team
    # Pas de code ici, juste une vue statique affichée
  end

  # Action pour la page "contact" - probablement une page statique
  def contact
    # Pas de code ici, juste une vue statique affichée
  end

  # Action pour la page "welcome" (accueil personnalisé)
  def welcome
    # Récupère la valeur du paramètre :first_name passé dans l'URL pour l'utiliser dans la vue
    @first_name = params[:first_name] || "Invite"
  end

end
