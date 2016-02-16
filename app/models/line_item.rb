class LineItem < ActiveRecord::Base
	belongs_to :product
	belongs_to :order 
	belongs_to :cart
	
	def total_price
	  product.price * quantity
	end

	def create_orderitem_from_line_item
		item = self
		hash_item = {:product_id => item.product_id, :quantity => item.quantity}
	end
  	
end
