class OrderItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :product
	belongs_to :line_items
	
	after_save :create_product_outstock, :on => :create

	def total_price
	  product.price * quantity
	end  
	def create_product_outstock
		ProductOutstock.create(:product_id => self.product_id, :product_quantity => self.quantity)
	end
	

end
