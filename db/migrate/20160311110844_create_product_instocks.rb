class CreateProductInstocks < ActiveRecord::Migration
  def change
    create_table :product_instocks do |t|
      t.integer :product_id
      t.integer :product_quantity

      t.timestamps null: false
    end
  end
end
