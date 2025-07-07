class Like < ApplicationRecord
    belongs_to :user   # Un like appartient à un utilisateur
    belongs_to :likeable, polymorphic: true   # Un like appartient à un "likeable" qui peut être de plusieurs types (Gossip ou Comment)

    validates :user_id, uniqueness: { scope: [:likeable_type, :likeable_id] }
  # Un utilisateur ne peut liker qu’une fois un même likeable (gossip ou comment)
end
