class AddJsonToRequestLabelDetail < ActiveRecord::Migration[6.1]
  def change
    add_column :request_label_details, :json, :string
  end
end
