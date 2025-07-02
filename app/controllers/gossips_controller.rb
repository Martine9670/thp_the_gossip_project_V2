class GossipsController < ApplicationController
  # Méthode pour afficher la liste de tous les potins
  def index
    # Récupère tous les potins en incluant les utilisateurs associés pour optimiser les requêtes
    @gossips = Gossip.all.includes(:user)
  end

  # Méthode pour afficher un potin spécifique
  def show
    # Trouve un potin par son id passé dans les paramètres de la requête
    @gossip = Gossip.find(params[:id])
  end

  # Méthode pour afficher le formulaire de création d'un nouveau potin
  def new
    # Initialise un nouvel objet Gossip vide pour le formulaire
    @gossip = Gossip.new
  end

  # Méthode pour créer un nouveau potin en base de données
  def create
    # Crée un nouvel objet Gossip avec les paramètres autorisés récupérés du formulaire
    @gossip = Gossip.new(gossip_params)
    # Tente de sauvegarder le potin en base
    if @gossip.save
      # Si succès, redirige vers la page du potin avec un message de confirmation
      redirect_to @gossip, notice: "Potin créé avec succès"
    else
      # Si échec, récupère tous les tags (probablement pour réafficher dans le formulaire)
      @tags = Tag.all
      # Affiche les messages d'erreur dans la console pour débogage
      puts @gossip.errors.full_messages
      # Réaffiche le formulaire de création pour que l'utilisateur corrige les erreurs
      render :new
    end
  end

  private

  # Méthode privée pour filtrer les paramètres autorisés du formulaire
  def gossip_params
    # Exige que les paramètres contiennent une clé :gossip et ne permet que :title, :content, :user_id
    params.require(:gossip).permit(:title, :content, :user_id)
  end
end
