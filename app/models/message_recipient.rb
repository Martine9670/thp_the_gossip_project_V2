class MessageRecipient < ApplicationRecord
  # Chaque enregistrement appartient à un message (clé étrangère message_id)
  belongs_to :message

  # Chaque enregistrement appartient à un utilisateur (destinataire, clé étrangère user_id)
  belongs_to :user
end
