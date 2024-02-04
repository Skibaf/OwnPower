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
require "test_helper"

class LessonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
