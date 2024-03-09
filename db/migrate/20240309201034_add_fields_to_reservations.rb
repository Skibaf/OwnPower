class AddFieldsToReservations < ActiveRecord::Migration[7.1]
  def change
    add_reference :reservations, :lesson, null: false, foreign_key: true
    add_column :reservations, :payment, :text
  end
end


