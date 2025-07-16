class UsersController < ApplicationController
  before_action :require_login, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # Liste des utilisateurs
  def index
    @users = User.all
  end

  # Affiche un utilisateur
  def show
    # @user déjà défini par set_user
  end

  # Formulaire d’inscription
  def new
    @user = User.new
  end

  # Création utilisateur
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Inscription confirmée ! 🎉 Tu peux maintenant te connecter !"
      redirect_to @user
    else
      Rails.logger.info(@user.errors.full_messages)
      render :new, status: :unprocessable_entity
    end
  end

  # Formulaire édition utilisateur
  def edit
    # @user déjà défini par set_user
  end

  # Mise à jour utilisateur
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profil mis à jour !"
    else
      Rails.logger.info(@user.errors.full_messages)
      flash.now[:alert] = "Échec de la mise à jour. Merci de corriger les erreurs."
      render :edit, status: :unprocessable_entity
    end
  end

  # Suppression utilisateur
  def destroy
    @user.destroy
    redirect_to root_path, notice: "Votre profil a bien été supprimé."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :birthdate, :city_id, :email, :password, :password_confirmation)
  end

  def require_login
    unless logged_in?
      flash[:alert] = "Vous devez être connecté pour accéder à cette page."
      redirect_to new_session_path
    end
  end
end
