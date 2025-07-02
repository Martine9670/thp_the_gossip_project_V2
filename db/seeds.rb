# Supprimer tout d'abord toutes les données existantes pour éviter doublons
Like.destroy_all
Comment.destroy_all
MessageRecipient.destroy_all
Message.destroy_all
GossipTag.destroy_all
Gossip.destroy_all
Tag.destroy_all
User.destroy_all
City.destroy_all


# Créer 10 villes
10.times do
  City.create!(
    # Crée une ville avec un nom aléatoire
    name: Faker::Address.city,
    # Crée un code postal aléatoire
    zip_code: Faker::Address.zip_code
  )
end

# Créer 10 utilisateurs liés à une ville
10.times do
  User.create!(
    # Prénom aléatoire
    first_name: Faker::Name.first_name,
    # Nom de famille aléatoire
    last_name: Faker::Name.last_name,
    # Description aléatoire (un paragraphe)
    description: Faker::Lorem.paragraph,
    # Email unique aléatoire
    email: Faker::Internet.unique.email,
    # Age aléatoire entre 18 et 65 ans
    age: rand(18..65),
    # Associe l’utilisateur à une ville choisie au hasard parmi toutes les villes créées
    city: City.all.sample,
    # mot de passe par défaut pour tous les users
    password: "azerty123",  
    password_confirmation: "azerty123"
  )
end

# Créer 20 gossips
20.times do
  Gossip.create!(
    # Titre aléatoire de 3 mots
    title: Faker::Lorem.sentence(word_count: 3),
    # Contenu aléatoire de 2 phrases
    content: Faker::Lorem.paragraph(sentence_count: 2),
    # Associe le gossip à un utilisateur choisi au hasard parmi tous les users
    user: User.all.sample
  )
end

# Créer 10 tags
10.times do
    Tag.create!(
      # Titre aléatoire unique pour chaque tag
        title: Faker::Lorem.unique.word
    )
end

# Pour chaque gossip, on va lui associer entre 1 et 3 tags au hasard
Gossip.all.each do |gossip|
    # Prend entre 1 et 3 tags choisis aléatoirement dans la base
    tags = Tag.order("RANDOM()").limit(rand(1..3))
    # Ajoute ces tags à ce gossip (association many-to-many)
    tags.each do |tag|
      GossipTag.create!(gossip: gossip, tag: tag)
  end
end

# Créer 10 messages privés
10.times do
  sender = User.all.sample  # On choisit un utilisateur au hasard pour être l'expéditeur du message
  recipients = User.where.not(id: sender.id).sample(rand(1..3))  # On choisit entre 1 et 3 destinataires différents, qui ne sont pas l'expéditeur

# On crée un message avec :
  # - un contenu généré aléatoirement (5 à 15 mots)
  # - l'expéditeur défini juste avant
  message = Message.create!(
    content: Faker::Lorem.sentence(word_count: rand(5..15)),
    sender: sender
  )

  # Pour chaque destinataire choisi :
  recipients.each do |recipient|  # On crée une relation entre le message et ce destinataire, grâce au modèle MessageRecipient (table de liaison)
    MessageRecipient.create!(message: message, user: recipient)
  end
end

# Créer un commentaire
20.times do
  Comment.create!(
    # Génère un contenu aléatoire pour le commentaire (un paragraphe)
    content: Faker::Lorem.paragraph,
    # Associe ce commentaire à un utilisateur choisi au hasard parmi tous les users
    user: User.all.sample,
    # Associe ce commentaire à un gossip choisi au hasard parmi tous les gossips
    gossip: Gossip.all.sample
  )
end

20.times do
  user = User.all.sample   # Sélectionne un utilisateur au hasard parmi tous les utilisateurs en base.
  likeable = [Gossip, Comment].sample.all.sample   # Choisit aléatoirement entre la classe Gossip ou Comment, puis prend un enregistrement au hasard parmi tous les gossips ou commentaires.
  # Crée un nouveau like avec l'utilisateur choisi et le gossip/commentaire choisi.
  Like.create!(   
    user: user,
    likeable: likeable
  )
  # Le point d'exclamation (!) signifie qu'une erreur sera levée si la création échoue.
end

puts "✅ Seeds terminés : villes, users, gossips, tags, messages privés, commentaires et likes créés."
