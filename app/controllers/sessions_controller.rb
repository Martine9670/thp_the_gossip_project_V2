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
    if params[:remember_me] == "1"
      log_in(user)  # Crée des cookies persistants + remember_token
    else
      # Crée des cookies temporaires (expire à la fermeture du navigateur)
      cookies.encrypted[:user_id] = {
        value: user.id,
        httponly: true,
        secure: Rails.env.production?
      }
      cookies.delete(:remember_token)
      user.forget
    end

    redirect_to root_path, notice: "Connecté !"
  else
    flash.now[:alert] = "Email ou mot de passe invalide"
    render :new
  end
end

  def destroy
    # Supprime le cookie à la déconnexion
    cookies.delete(:user_id)
    redirect_to root_path, notice: "Vous êtes Déconnecté !"
  end
end
