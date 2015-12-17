class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.integer :category_id
      t.string :uniq_code
      t.string :code
      t.string :color

      t.timestamps null: false
    end
  end
end
