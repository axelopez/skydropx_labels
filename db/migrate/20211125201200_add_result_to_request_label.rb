class AddResultToRequestLabel < ActiveRecord::Migration[6.1]
  def change
    add_column :request_labels, :result, :text
  end
end
