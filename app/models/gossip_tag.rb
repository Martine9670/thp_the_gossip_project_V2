class GossipTag < ApplicationRecord
  # Chaque enregistrement appartient à un gossip (clé étrangère gossip_id)
  belongs_to :gossip

  # Chaque enregistrement appartient à un tag (clé étrangère tag_id)
  belongs_to :tag
end

