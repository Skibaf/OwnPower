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
require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
