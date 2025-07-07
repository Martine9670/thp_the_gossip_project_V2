  class Gossip < ApplicationRecord
  # Chaque gossip appartient à un utilisateur (auteur)
  belongs_to :user

  # Validation pour s’assurer que le champ title est présent (non vide)
  validates :title, presence: true

  # Validation pour s’assurer que le champ content est présent (non vide)
  validates :content, presence: true

  # Un gossip peut avoir plusieurs enregistrements dans la table de liaison gossip_tags
  has_many :gossip_tags, dependent: :destroy

  # Un gossip peut être associé à plusieurs tags via la table de liaison gossip_tags (relation many-to-many)
  has_many :tags, through: :gossip_tags

  # Un gossip peut avoir plusieurs commentaires
  # ATTENTION : ici il faut mettre le pluriel 'comments' pour que Rails comprenne bien la relation
  has_many :comments, dependent: :destroy

# Relations pour les likes polymorphes
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user
end

