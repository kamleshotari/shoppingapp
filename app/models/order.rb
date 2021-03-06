class Order < ActiveRecord::Base
	has_many :order_items, :dependent => :destroy
  attr_accessor :card_number, :exp_month, :exp_year, :cvv_number
  belongs_to :cart
  belongs_to :user
  has_one :payment
  PAYMENT_TYPES = [ "---Select Payment Mode---","Credit card", "Cash On Delivery" ]  
  validates_length_of :zip_code, :maximum => 6
  validates :name, :address, :email, :pay_type, :presence => true

  validates :card_number, :presence => {:message => "Card number cannot be blank" }, :numericality => {:only_integer => true},
            :length => {:maximum => 16, :minimum => 16}, :if => Proc.new {|p| pay_type == "Credit card"}
  validates :exp_month, :presence => {:message => "Expiry month can't be blank." }, :numericality => {:only_integer => true},
            :length => {:maximum => 2, :minimum => 2}, :if => Proc.new {|p| pay_type == "Credit card"}
  validates :exp_year,  :presence => {:message => "Expiry Year can't be blank." }, :numericality => {:only_integer => true},
            :length => {:maximum => 4, :minimum => 4}, :if => Proc.new {|p| pay_type == "Credit card"}
  validates :cvv_number, :presence => {:message => "CVV Number can't be blank." }, :numericality => {:only_integer => true},
            :length => {:maximum => 3, :minimum => 3}, :if => Proc.new {|p| pay_type == "Credit card"}
  
  after_save :charge_card, :create_first_address, :on => :create

  def add_order_item_from_cart(cart) 
    cart.line_items.each do |item|
      OrderItem.create(item.create_orderitem_from_line_item.merge({:order_id => self.id}))
    end 
  end  

  def validate_product_stock(cart)
    arry = []
    cart.line_items.each do |item|
      if Product.get_total_stock(item.product) <= 0
        arry << false
      else
        arry << true
      end
      arry
    end
    if arry.include?(false)
      false
    else
      true
    end
  end

  


  def grand_total_price 
    order_items.to_a.sum { |item| item.total_price }
  end  

  def get_token

    begin
      token = Stripe::Token.create(
        :card => {
          :number => self.card_number,
          :exp_month => self.exp_month,
          :exp_year => self.exp_year,
          :cvc => self.cvv_number
        },
      )
      token
    rescue Stripe::CardError => e
      body = e.json_body
      err  = body[:error]
      err
    end
  end

  def charge_card
    token = self.get_token
    if token[:type] == "card_error"
      token
    else
      begin
        response = Stripe::Charge.create(
          :amount => 400,
          :currency => "usd",
          :source => token.id,
          :description => "Charge for test@example.com"
        )
        Payment.create(:pg_response => response.to_json, :order_id => self.id, :status => response["captured"])
      rescue Stripe::InvalidRequestError => e
        body = e.json_body
        err  = body[:error]
        Payment.create(:pg_response => err.to_json, :order_id => self.id, :status => false)
        err
      end
    end
  end

  def create_first_address
    if self.user.addresses.blank?
      Address.create(:user_id => self.user_id, :city => self.city, :state => self.state, :address => self.address, :zip_code => self.zip_code, :country => self.country, :contact_no => self.contact_no)
    end

  end
end
