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
class Token < ApplicationRecord
    validates_presence_of :customer, :token    

    def name
        self.customer
    end
end
