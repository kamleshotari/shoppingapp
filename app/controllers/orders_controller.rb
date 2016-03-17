class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  layout "user_layout"
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
    @orders = Order.page(params[:page]).per(5)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
    @cart = current_cart
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    if current_cart.line_items.empty?
      redirect_to store_url, :notice => "Your cart is empty"
      return
    end
  end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @cart = current_cart

    #@order.add_line_items_from_cart(current_cart)

    respond_to do |format|
      if @order.validate_product_stock(@cart) && @order.save
        if @order.payment.present? && @order.payment.status == true
          @order.add_order_item_from_cart(@cart)
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil                
          # send order confirmation email
          #Notifier.order_received(@order).deliver
          format.html { redirect_to(@order, :notice => ('thanks')) }

        else
          format.html { redirect_to('/store/error', :notice => ('Failed transaction')) }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @order.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'order was successfully updated.' }
        format.json { render :show, status: :OK, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end
    
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type, :city, :state, :contact_no, :zip_code, :country ,:card_number, :exp_month, :exp_year, :cvv_number)
    end
end
