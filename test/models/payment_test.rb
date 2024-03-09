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
require "test_helper"

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
