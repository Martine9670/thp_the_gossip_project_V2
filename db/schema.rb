ActiveRecord::Schema[8.0].define(version: 2025_06_24_132437) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "gossip_id", null: false
    t.index ["gossip_id"], name: "index_comments_on_gossip_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "gossip_tags", force: :cascade do |t|
    t.bigint "gossip_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gossip_id"], name: "index_gossip_tags_on_gossip_id"
    t.index ["tag_id"], name: "index_gossip_tags_on_tag_id"
  end

  create_table "gossips", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_gossips_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "likeable_type", null: false
    t.bigint "likeable_id", null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "message_recipients", force: :cascade do |t|
    t.bigint "message_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_message_recipients_on_message_id"
    t.index ["user_id"], name: "index_message_recipients_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sender_id", null: false
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.text "description"
    t.string "email"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "city_id"
    t.index ["city_id"], name: "index_users_on_city_id"
  end

  add_foreign_key "comments", "gossips"
  add_foreign_key "comments", "users"
  add_foreign_key "gossip_tags", "gossips"
  add_foreign_key "gossip_tags", "tags"
  add_foreign_key "gossips", "users"
  add_foreign_key "likes", "users"
  add_foreign_key "message_recipients", "messages"
  add_foreign_key "message_recipients", "users"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "users", "cities"
end



=begin
EXPLICATIONS :

GENERAL :
- Le fichier définit la structure actuelle de la base de données (générée automatiquement par Rails).
- Chaque `create_table` correspond à une table.
- `t.*` décrit les colonnes : type + nom.
- `t.index` crée des index pour optimiser les requêtes.
- `add_foreign_key` définit les liens entre les tables (clés étrangères).

TABLES CLÉS :

1. cities :
   - Contient les villes.
   - Champs : name, zip_code, timestamps.

2. users :
   - Représente les utilisateurs.
   - Lié à une ville via city_id (clé étrangère).
   - Infos personnelles + timestamps.

3. gossips :
   - Les potins.
   - Liés à un user (auteur).
   - Champs : title, content.

4. comments :
   - Commentaires sur les potins.
   - Liés à un gossip et un user.

5. tags :
   - Étiquettes pour classer les potins.

6. gossip_tags :
   - Table de liaison Many-to-Many entre gossips et tags.

7. messages :
   - Messages privés envoyés par les utilisateurs.
   - Liés à sender_id (l’expéditeur).

8. message_recipients :
   - Table de liaison entre messages et destinataires (users).

9. likes :
   - Système de likes polymorphe (peut liker des potins ou des commentaires).
   - likeable_type & likeable_id gèrent le polymorphisme.

EXTENSIONS :
- enable_extension "pg_catalog.plpgsql" : active des fonctionnalités spécifiques de PostgreSQL.

=end