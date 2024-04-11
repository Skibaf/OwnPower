# == Schema Information
#
# Table name: lessons
#
#  id          :bigint           not null, primary key
#  coach_id    :bigint           not null
#  category_id :bigint           not null
#  precio      :integer
#  status      :integer          default("disponible")
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
  has_many :reservations
  has_many :orderables
  has_many :carts, through: :orderables

  
  #Validaciones de reglas de negocio
  validates :precio, numericality: { greater_than: 0, message: ": El precio debe ser mayor que cero" }
  validates :status, presence: true
  validates :coach, presence:  { message: ": Ingresa por favor un profesor" }
  validate :date_cannot_be_in_the_past
  validates_presence_of :category, message: ": Debes seleccionar una categoría"
  validates_presence_of :dia, message: ": Debes seleccionar una fecha"
  #validar hora final es despues de inicio
  validates :fin, comparison: { greater_than: :inicio, message: ": La hora de fin debe ser mayor que la hora de inicio" }
  
  enum status: [:disponible, :reservada, :cancelada]

  #defino opcione sde busqueda
  #upcoming son los registros disponibles que estan en los proximos 30 dias 
  scope :upcoming, ->{ where('dia BETWEEN ? AND ?', Date.tomorrow, 30.days.from_now)}
  #disponible trae todo los que esta en esta condicion sin restriccion de fecha
  scope :disponibles, ->{ where(status: :disponible) }
  #devuelve las lecciones desde dia y por un perido de 30 en el futuro
  
  #Atributos para usar search en las vistas
  def self.ransackable_attributes(auth_object = nil)
    [ "category_id", "coach_id", "created_at", "dia", "fin", "inicio", "precio", "status", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "category", "coach", "user"]
  end
  
  #funcion para ver si es editable por el profesor
  def disponible?
    self.status == "disponible"
  end

  

  #Logica BU- No se puede crear clase en el pasado
  def date_cannot_be_in_the_past
    if dia.present? && dia < Date.today
      errors.add(:dia, "No se puede crear una clase en el pasado. Si es para modificar cancelalá y crea una nueva.")
    end
  end
  

  def full_description
    full="#{lesson.id} - #{lesson.coach} - #{lesson.dia} - #{lesson.inicio}"
    return full
  end

end
