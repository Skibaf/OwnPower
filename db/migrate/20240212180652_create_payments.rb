class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :user_id, null: false, foreign_key: { to_table: :users}
      t.integer :total

      t.timestamps
    end
  end
end
