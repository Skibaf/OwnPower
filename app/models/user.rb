# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  fisrt_name             :string
#  last_name              :string
#  username               :string
#  role                   :integer
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :lessons
  has_many :payments
  has_many :reservations
  has_one_attached :avatar
  
  enum role: [:user, :coach, :admin]
  
  #reglas de negocio
  after_initialize :set_default_role, :if => :new_record?
  validates :email, presence: true
  #validates :fisrt_name, presence: true
 # validates :last_name, presence: true
   
   
   def set_default_role
      
      self.role ||= :user if self.role.nil?
   end
  
   def admin?
    role == "admin"
   end

   def coach?
    role == "coach"
   end
  
   def full_name
      "#{fisrt_name.capitalize unless fisrt_name.nil?} #{last_name.capitalize unless last_name.nil?}"
   end

   def self.ransackable_attributes(auth_object = nil)
    ["email", "id", "last_name", "fisrt_name"]
   end

   def initials
      # Obtener el primer y último nombre del usuario
      first_name_initial = fisrt_name.present? ? fisrt_name[0] : ''
      last_name_initial = last_name.present? ? last_name[0] : ''
  
      # Concatenar las iniciales y devolverlas en mayúscula
      "#{first_name_initial}#{last_name_initial}".upcase
    end


end
