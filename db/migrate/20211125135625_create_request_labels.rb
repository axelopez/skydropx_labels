class CreateRequestLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :request_labels do |t|
      t.string :reference
      t.references :token, null: false, foreign_key: true
      t.string :status
      t.text :request

      t.timestamps
    end
  end
end
