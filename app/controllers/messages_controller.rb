class MessagesController < ApplicationController
  before_action :require_login  # interdit l'accès si pas connecté

  def index
    # afficher les messages reçus de current_user
    @received_messages = current_user.received_messages.includes(:sender).order(created_at: :desc)
  end

  def sent
    # afficher les messages envoyés par current_user
    @sent_messages = current_user.sent_messages.includes(:recipients).order(created_at: :desc)
  end

  def new
    @message = Message.new
    @users = User.where.not(id: current_user.id) # Pour choisir les destinataires (hors expéditeur)
  end

  def create
    @message = Message.new(message_params)
    @message.sender = current_user

    if @message.save
      # Associer les destinataires (table join)
      if params[:message][:user_ids].present?
        params[:message][:user_ids].each do |user_id|
          MessageRecipient.create!(message: @message, user_id: user_id) unless user_id.blank?
        end
      end
      redirect_to messages_path, notice: "Message envoyé avec succès !"
    else
      @users = User.where.not(id: current_user.id)
      flash.now[:alert] = "Erreur lors de l'envoi du message."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
    # sender_id est fixé dans le contrôleur (current_user)
    # user_ids est traité à part pour les destinataires (dans create)
  end
end
