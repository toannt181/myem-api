class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.references :customer
      t.string :province_id
      t.string :district_id
      t.string :ward_id
      t.integer :current_diagnosis
      t.timestamps
    end
  end
end
