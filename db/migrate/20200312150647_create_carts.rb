class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.references :user
      t.text :saved_products, array: true, default: []
      t.timestamps
    end
  end
end
