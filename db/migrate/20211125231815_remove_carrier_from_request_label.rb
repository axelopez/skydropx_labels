class RemoveCarrierFromRequestLabel < ActiveRecord::Migration[6.1]
  def change
    remove_column :request_labels, :carrier, :string
  end
end
