class CreateDiagnoses < ActiveRecord::Migration[6.0]
  def change
    create_table :diagnoses do |t|
      t.references :customer
      t.date :year
      t.string :name
      t.timestamps
    end
  end
end
