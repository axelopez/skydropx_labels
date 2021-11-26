class AddTryCountToRequestLabel < ActiveRecord::Migration[6.1]
  def change
    add_column :request_labels, :try_count, :integer
  end
end
