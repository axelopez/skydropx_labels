class RemoveReferenceFromRequestLabel < ActiveRecord::Migration[6.1]
  def change
    remove_column :request_labels, :reference, :string
  end
end
