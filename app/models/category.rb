# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :integer          default("activa")
#
class Category < ApplicationRecord
    has_many :lessons
    validates :title, presence: true
    validates :status, presence: true
    enum status: [:activa, :inactivo]


    def self.ransackable_attributes(auth_object = nil)
        ["title", "id", "description"]
    end

end
