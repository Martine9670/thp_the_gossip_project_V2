
class MessagesController < ApplicationController
  before_action :authenticate_user! # si devise ou autre méthode de connexion

  def index
    # Messages reçus
    @received_messages = current_user.received_messages.includes(:sender).order(created_at: :desc)
  end

  def sent
    # Messages envoyés
    @sent_messages = current_user.sent_messages.includes(:recipients).order(created_at: :desc)
  end
end
