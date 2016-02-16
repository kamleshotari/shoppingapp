class AddAttributesToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :country, :string
    add_column :orders, :zip_code, :string
    add_column :orders, :contact_no, :string
    add_column :orders, :cart_id, :integer
  end
end
