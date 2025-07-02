class UsersController < ApplicationController

  # Action pour afficher la liste de tous les utilisateurs
  def index
    # Récupère tous les utilisateurs de la base de données
    @users = User.all
  end

  # Action pour afficher un utilisateur spécifique
  def show
    # Trouve un utilisateur par son id passé dans les paramètres de la requête
    @user = User.find(params[:id])
  end
end
