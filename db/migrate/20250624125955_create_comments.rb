class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :gossip, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
