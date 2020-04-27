class CreateDivisions < ActiveRecord::Migration[6.0]
  def change
    create_table :divisions do |t|
      t.string :name
      t.integer :sort
      t.references :diagnosis
      t.timestamps
    end
  end
end
