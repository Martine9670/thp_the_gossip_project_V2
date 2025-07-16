module SessionsHelper
  # Connecte l'utilisateur
  def log_in(user)
    session[:user_id] = user.id
  end

  # "Se souvenir de moi" : stocke des cookies persistants
  def remember(user)
    remember_token = SecureRandom.urlsafe_base64
    user.remember(remember_token) # Cette méthode doit stocker le digest en base
    cookies.permanent[:user_id] = user.id
    cookies.permanent[:remember_token] = remember_token
  end

  # Renvoie l'utilisateur actuellement connecté (ou nil)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])

    elsif cookies[:user_id]
      user = User.find_by(id: cookies[:user_id])

      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
  end

  # Vérifie si un utilisateur est connecté
  def logged_in?
    current_user.present?
  end

  # Oublie l'utilisateur persistant
  def forget(user)
    user.update(remember_digest: nil)    
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Déconnecte l'utilisateur
  def log_out(user)
    session.delete(:user_id)
    forget(user)
  end

end
