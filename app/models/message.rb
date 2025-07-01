class Message < ApplicationRecord
  # Chaque message appartient à un expéditeur (un utilisateur)
  # 'sender' est un nom personnalisé pour la relation
  # 'class_name: "User"' précise que l’expéditeur est un User
  belongs_to :sender, class_name: "User"

  # Un message peut avoir plusieurs enregistrements dans la table message_recipients
  # Cette table fait le lien entre un message et ses destinataires
  has_many :message_recipients

  # Un message peut avoir plusieurs destinataires (utilisateurs)
  # 'recipients' permet d’accéder aux utilisateurs destinataires via message_recipients
  # 'through: :message_recipients' signifie qu’on passe par la table de liaison
  # 'source: :user' indique que la colonne user dans message_recipients est utilisée
  has_many :recipients, through: :message_recipients, source: :user

  # Validation pour s’assurer que le contenu du message est toujours présent (non vide)
  validates :content, presence: true
end
