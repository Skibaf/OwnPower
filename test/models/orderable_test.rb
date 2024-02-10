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
require "test_helper"

class OrderableTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
