class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.boolean :status
      t.text :pg_response

      t.timestamps null: false
    end
  end
end
