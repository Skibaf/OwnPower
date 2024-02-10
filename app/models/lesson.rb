# == Schema Information
#
# Table name: lessons
#
#  id          :bigint           not null, primary key
#  coach_id    :bigint           not null
#  category_id :bigint           not null
#  precio      :integer
#  status      :integer          default(0)
#  dia         :date
#  inicio      :time
#  fin         :time
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Lesson < ApplicationRecord
  
  #Relaciones
  belongs_to :coach, class_name: 'User'
  belongs_to :category
  has_many :orderables
  has_many :carts, through: :orderables

  #Validaciones de reglas de negocio
  validates :precio, numericality: { greated_than: 0}
  validates :status, presence: true
  validate :date_cannot_be_in_the_past
    #validar hora final es despues de inicio
  validates :fin, comparison: { greater_than: :inicio }
  
  enum status: [:disponible, :reservada, :cancelada]


  scope :upcoming, ->{ where('dia BETWEEN ? AND ?', Date.tomorrow, 30.days.from_now).where(status: :disponible) }
  scope :disponible, ->{ where(status: :disponible) }
  



  def date_cannot_be_in_the_past
    if dia < Date.today
      errors.add(:dia, "No puede estar en el pasado")
    end
  end
end
