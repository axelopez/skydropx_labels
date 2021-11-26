# == Schema Information
#
# Table name: request_label_details
#
#  id               :bigint           not null, primary key
#  request_label_id :bigint           not null
#  status           :string
#  file_url         :string
#  shipment_id      :integer
#  tracking_number  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  result           :string
#  carrier          :string
#  json             :string
#
require "test_helper"

class RequestLabelDetailTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
