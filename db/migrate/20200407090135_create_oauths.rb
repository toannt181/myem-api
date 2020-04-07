class CreateOauths < ActiveRecord::Migration[6.0]
  def change
    create_table :oauths do |t|
      t.string :provider
      t.references :user
      t.timestamps
    end
  end
end
