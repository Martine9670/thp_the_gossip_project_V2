class RemoveAgeFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :age, :integer
  end
end
