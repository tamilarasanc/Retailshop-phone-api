class CreateShipping < ActiveRecord::Migration[6.0]
  def change
    create_table :shippings do |t|
      t.string :name
      t.text :address1
      t.text :address2
      t.string :state
      t.string :city
      t.integer :postal_code
      t.timestamps
    end
  end
end
