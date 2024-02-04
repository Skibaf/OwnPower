class CreateLessons < ActiveRecord::Migration[7.1]
  def change
    create_table :lessons do |t|
      t.references :coach, null: false, foreign_key: { to_table: :users}
      t.references :category, null: false, foreign_key: true
      t.integer :precio
      t.integer :status, default: 0
      t.date :dia
      t.time :inicio
      t.time :fin

      t.timestamps
    end
  end
end
