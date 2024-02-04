class AddStatusToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :status, :integer, :default => 0
  end
end
