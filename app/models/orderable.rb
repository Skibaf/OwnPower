class Orderable < ApplicationRecord
  #Relaciones
  belongs_to :lesson
  belongs_to :cart

  #calculo de la linea
  def total
    lesson.precio * 1
  end
end
