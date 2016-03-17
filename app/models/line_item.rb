class LineItem < ActiveRecord::Base
	belongs_to :product
	belongs_to :order 
	belongs_to :cart
	
	validate :validate_product_stock
	
	def total_price
	  product.price * quantity
	end

	def create_orderitem_from_line_item
		item = self
		hash_item = {:product_id => item.product_id, :quantity => item.quantity}
	end

	def validate_product_stock
		product = Product.find self.product_id
		if Product.get_total_stock(product) <= 0
			self.errors.add(:product_id, "Product out of stock.")
		end
	end
  	
end
