class AddUserToGossips < ActiveRecord::Migration[8.0]
  def change
    add_reference :gossips, :user, foreign_key: true  end
end
