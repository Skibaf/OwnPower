# == Schema Information
#
# Table name: orderables
#
#  id         :bigint           not null, primary key
#  lesson_id  :bigint           not null
#  cart_id    :bigint           not null
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Orderable < ApplicationRecord
  #Relaciones
  belongs_to :lesson
  belongs_to :cart

  #calculo de la linea
  def total
    lesson.precio * 1
  end
end
