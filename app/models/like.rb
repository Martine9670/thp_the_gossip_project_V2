class Like < ApplicationRecord
    belongs_to :user   # Un like appartient à un utilisateur
    belongs_to :likeable, polymorphic: true   # Un like appartient à un "likeable" qui peut être de plusieurs types (Gossip ou Comment)
end
