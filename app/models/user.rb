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
  has_many :likes, dependent: :destroy
  has_many :liked_gossips, through: :likes, source: :gossip

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
  # Validation personnalisée pour birthdate
  validate :birthdate_must_be_valid


   # Vérifie si l'utilisateur a liké un objet donné (gossip ou comment)
  def liked?(likeable)
    likes.exists?(likeable: likeable)
  end
   # Méthode pour calculer l'âge dynamiquement
  def age
    return unless birthdate

    today = Date.today
    age = today.year - birthdate.year
    anniversaire = Date.new(today.year, birthdate.month, birthdate.day)
    age -= 1 if today < anniversaire
    age
  end

  def remember(remember_token)
    remember_digest = BCrypt::Password.create(remember_token)
    self.update(remember_digest: remember_digest)
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update(remember_digest: nil)
  end

  private

  def birthdate_must_be_valid
    return if birthdate.blank?

    if birthdate > Date.today
      errors.add(:birthdate, ": La date renseignée ne peut pas être dans le futur")
    elsif birthdate < 120.years.ago
      errors.add(:birthdate, ": La date renseignée est trop ancienne pour être valide")
    end
  end
end
