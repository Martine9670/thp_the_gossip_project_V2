class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    # Retourne un user existant, ici juste pour test
    User.first
  end
end

end
