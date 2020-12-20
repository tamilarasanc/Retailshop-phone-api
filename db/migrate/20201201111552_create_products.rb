class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :manufacturer
      t.string :model
      t.string :storage
      t.integer :year
      t.string :color
      t.float :price
      t.integer :shop_id
      t.index :shop_id
      t.column :status, :integer, default: 0
      t.timestamps
    end
  end
end
