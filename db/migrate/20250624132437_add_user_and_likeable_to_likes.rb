class AddUserAndLikeableToLikes < ActiveRecord::Migration[8.0]
  def change

    add_reference :likes, :user, null: false, foreign_key: true

    # Ajoute une colonne user_id dans la table likes
    # Cette colonne est une référence à la table users
    # null: false => cette colonne ne peut pas être vide (obligatoire)
    # foreign_key: true => ajoute une contrainte d'intégrité référentielle en base (clé étrangère)

    add_reference :likes, :likeable, polymorphic: true, null: false
    
    # Ajoute deux colonnes polymorphes dans la table likes :
    # likeable_type (string) et likeable_id (integer)
    # Ces colonnes permettent de faire référence à plusieurs modèles différents (Gossip, Comment, etc.)
    # null: false => ces colonnes doivent obligatoirement être renseignées
  end
end
