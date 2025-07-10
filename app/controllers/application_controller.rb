class ApplicationController < ActionController::Base
  include SessionsHelper  # Inclusion du helper
  helper_method :current_user, :logged_in?  # Permet l'accès dans les vues

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Vous devez être connecté pour accéder à cette page."
    end
  end

  alias_method :authenticate_user!, :require_login
end


