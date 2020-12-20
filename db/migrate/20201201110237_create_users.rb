class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email_id
      t.string :password
      t.integer :role_id
      t.integer :shop_id
      t.index :role_id
      t.index :shop_id
      t.column :status, :integer, default: 0
      t.timestamps
    end
  end
end
