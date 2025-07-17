module SessionsHelper
  # Connecte l'utilisateur en créant un cookie persistant
  def log_in(user)
    remember_token = SecureRandom.urlsafe_base64
    user.update(remember_digest: digest(remember_token))

    cookies.encrypted[:user_id] = {
      value: user.id,
      expires: 2.weeks.from_now,
      httponly: true,
      secure: Rails.env.production?
    }

    cookies.encrypted[:remember_token] = {
      value: remember_token,
      expires: 2.weeks.from_now,
      httponly: true,
      secure: Rails.env.production?
    }
  end

  # Renvoie l'utilisateur connecté ou nil
  def current_user
    @current_user ||= begin
      user_id = cookies.encrypted[:user_id]
      token = cookies.encrypted[:remember_token]
      user = User.find_by(id: user_id)

      if user && user.authenticated?(:remember, token)
        user
      else
        nil
      end
    end
  end

  # Vérifie si un utilisateur est connecté
  def logged_in?
    current_user.present?
  end

  # Oublie l'utilisateur (supprime le cookie et le token en base)
  def forget(user)
    user.update(remember_digest: nil)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Déconnecte complètement
  def log_out(user)
    forget(user)
    @current_user = nil
  end

  private

  def digest(token)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(token, cost: cost)
  end
end
