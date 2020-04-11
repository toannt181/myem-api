class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.references :customer
      t.integer :province
      t.integer :district
      t.integer :ward
      t.timestamps
    end
  end
end
