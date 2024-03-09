# == Schema Information
#
# Table name: payments
#
#  id         :bigint           not null, primary key
#  user_id_id :bigint           not null
#  total      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Payment < ApplicationRecord
  belongs_to :user_id, class_name: 'User'
end
