class Order < ActiveRecord::Base
	has_many :order_items, :dependent => :destroy
  belongs_to :cart
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]  
  
  validates :name, :address, :email, :pay_type, :presence => true

  def add_order_item_from_cart(cart) 
    cart.line_items.each do |item|
      OrderItem.create(item.create_orderitem_from_line_item.merge({:order_id => self.id}))
    end 
  end  
  def grand_total_price 
    order_items.to_a.sum { |item| item.total_price }
  end  
end
