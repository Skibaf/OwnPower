# == Schema Information
#
# Table name: reservations
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lesson_id  :bigint           not null
#  payment    :text
#
class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  has_one :category, through: :orderables
   
  enum status: [:Pendiente, :Pagada]
  validates :status, presence: true


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "lesson_id", "status", "payment"]
  end
end
