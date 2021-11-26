class AddCarrierToRequestLabel < ActiveRecord::Migration[6.1]
  def change
    add_column :request_labels, :carrier, :string
  end
end
