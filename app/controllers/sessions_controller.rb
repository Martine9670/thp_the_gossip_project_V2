class SessionsController < ApplicationController
  def new
  end

  def create
    password = params[:password]

    if password.nil? || password.length < 8
      flash.now[:alert] = "Le mot de passe doit contenir au moins 8 caractères."
      return render :new
    end

    user = User.find_by(email: params[:email])
    if user && user.authenticate(password)
      session[:user_id] = user.id
      remember(user)
      redirect_to root_path, notice: "Connecté !"
    else
      flash.now[:alert] = "Email ou mot de passe invalide"
      render :new
    end
  end

  def destroy
    log_out(current_user)
    redirect_to root_path, notice: "Vous êtes Déconnecté !"
  end
end
