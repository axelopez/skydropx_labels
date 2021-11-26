# == Schema Information
#
# Table name: tokens
#
#  id         :bigint           not null, primary key
#  customer   :string
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class TokenTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
