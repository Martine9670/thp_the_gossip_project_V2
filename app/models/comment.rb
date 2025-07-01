class Comment < ApplicationRecord
  # Chaque commentaire appartient à un gossip (clé étrangère gossip_id)
  belongs_to :gossip

  # Chaque commentaire appartient à un utilisateur (auteur du commentaire)
  belongs_to :user

  # Un commentaire peut avoir plusieurs likes grâce à la relation polymorphe
  # 'as: :likeable' signifie que ce modèle peut être "liké"
  has_many :likes, as: :likeable
end

