# == Schema Information
#
# Table name: request_labels
#
#  id         :bigint           not null, primary key
#  token_id   :bigint           not null
#  status     :string
#  request    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  identifier :string
#  result     :text
#  try_count  :integer
#
require "test_helper"

class RequestLabelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
