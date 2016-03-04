class AddAttributesToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :city, :string
    add_column :addresses, :state, :string
    add_column :addresses, :country, :string
    add_column :addresses, :zip_code, :string
    add_column :addresses, :contact_number, :string
  end
end
