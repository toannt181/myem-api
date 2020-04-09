class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :code
      t.string :name
      t.string :pic_name
      t.timestamps
    end
  end
end
