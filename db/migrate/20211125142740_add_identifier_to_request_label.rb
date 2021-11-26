class AddIdentifierToRequestLabel < ActiveRecord::Migration[6.1]
  def change
    add_column :request_labels, :identifier, :string
  end
end
