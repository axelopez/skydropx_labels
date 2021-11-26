class CreateRequestLabelDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :request_label_details do |t|
      t.references :request_label, null: false, foreign_key: true
      t.string :status
      t.string :file_url
      t.integer :shipment_id
      t.string :tracking_number

      t.timestamps
    end
  end
end
