class AddResultToRequestLabelDetail < ActiveRecord::Migration[6.1]
  def change
    add_column :request_label_details, :result, :string
  end
end
