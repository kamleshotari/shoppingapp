class OrderItem < ActiveRecord::Base
	belongs_to :order
	belongs_to :product
	belongs_to :line_items
	#has_many :line_items
	
	def total_price
	  product.price * quantity
	end  

end
