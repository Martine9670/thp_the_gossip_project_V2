class User < ApplicationRecord
  # Un utilisateur appartient à une ville (relation Many-to-One)
  belongs_to :city

  # Un utilisateur peut avoir plusieurs potins (relation One-to-Many)
  has_many :gossips

  # Un utilisateur peut envoyer plusieurs messages (relation One-to-Many)
  # On précise la classe Message et la clé étrangère sender_id dans la table messages
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"

  # Association avec la table intermédiaire message_recipients qui lie utilisateurs et messages reçus
  has_many :message_recipients

  # Un utilisateur peut recevoir plusieurs messages via la table message_recipients
  # On précise la source des messages reçus par cette relation
  has_many :received_messages, through: :message_recipients, source: :message

  # Un utilisateur peut écrire plusieurs commentaires
  has_many :comments

  # Un utilisateur peut avoir plusieurs likes (sur potins, commentaires, etc.)
  has_many :likes

  has_secure_password
end
