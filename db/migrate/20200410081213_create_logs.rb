class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.string :action
      t.integer :status
      t.string :content, :comment => '0: pending, 1: start, 2: success, 3: fail'
      t.timestamps
    end
  end
end
