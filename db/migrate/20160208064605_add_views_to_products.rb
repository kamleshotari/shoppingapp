class AddViewsToProducts < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.attachment :view1
      t.attachment :view2
      t.attachment :view3
    end
  end
end
