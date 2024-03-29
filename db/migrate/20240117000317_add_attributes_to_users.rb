class AddAttributesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :fisrt_name, :string
    add_column :users, :last_name, :string
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :role, :integer
  end
end
