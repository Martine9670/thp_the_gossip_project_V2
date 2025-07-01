class Gossip < ApplicationRecord
  # Chaque gossip appartient à un utilisateur (auteur)
  belongs_to :user

  # Un gossip peut avoir plusieurs enregistrements dans la table de liaison gossip_tags
  has_many :gossip_tags

  # Un gossip peut être associé à plusieurs tags via la table de liaison gossip_tags (relation many-to-many)
  has_many :tags, through: :gossip_tags

  # Un gossip peut avoir plusieurs commentaires
  # ATTENTION : ici il faut mettre le pluriel 'comments' pour que Rails comprenne bien la relation
  has_many :comments

  # Un gossip peut avoir plusieurs likes grâce à la relation polymorphe
  # 'as: :likeable' indique que le gossip est un modèle "likable" dans la relation polymorphe
  has_many :likes, as: :likeable
end

