class Tag < ApplicationRecord
  # Un tag peut être associé à plusieurs enregistrements dans la table de liaison gossip_tags
  has_many :gossip_tags

  # Un tag peut être lié à plusieurs gossips via la table de liaison gossip_tags (relation many-to-many)
  has_many :gossips, through: :gossip_tags
end
