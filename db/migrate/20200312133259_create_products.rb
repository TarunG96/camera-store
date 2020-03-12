class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :category
      t.string :name
      t.string :description
      t.float :price
      t.integer :make
      t.timestamps
    end
  end
end
