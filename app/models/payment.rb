class Payment < ApplicationRecord
  belongs_to :user_id, class_name: 'User'
end