class UsersController < ApplicationController

  # Liste des utilisateurs
  def index
    @users = User.all
  end

  # Affiche un utilisateur
  def show
    @user = User.find(params[:id])
  end

  # Formulaire d’inscription
  def new
    @user = User.new
  end

  # Création utilisateur
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "Utilisateur créé avec succès !"
    else
      Rails.logger.info(@user.errors.full_messages)
      render :new, status: :unprocessable_entity
    end
  end

  # Formulaire édition utilisateur
  def edit
    @user = User.find(params[:id])
  end

  # Mise à jour utilisateur
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "Profil mis à jour !"
    else
      Rails.logger.info(@user.errors.full_messages)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :age, :city_id, :email, :password, :password_confirmation)
  end
end
