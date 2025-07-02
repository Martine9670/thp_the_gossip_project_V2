class UsersController < ApplicationController

  # Action pour afficher la liste de tous les utilisateurs
  def index
    @users = User.all
  end

  # Action pour afficher un utilisateur spécifique
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "Utilisateur créé avec succès !"
    else
      Rails.logger.info(@user.errors.full_messages)
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description, :email, :password, :password_confirmation, :city_id)
  end
end
