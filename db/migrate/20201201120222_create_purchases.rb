class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.integer :product_id
      t.index :product_id
      t.integer :shipping_id
      t.index :shipping_id
      t.datetime :date
      t.timestamps
    end
  end
end
