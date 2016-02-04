class StoreController < ApplicationController
  layout "user_layout"
  skip_before_filter :authenticate_user!
  
  def index
    @cart = current_cart
  	if params[:code].present?
    	@category = Category.where(params[:code])
    else 
    	@category = Category.all
    end
    @products = Product.where("category_id IN (?)", @category.pluck(:id))
    @products = Product.order(:title)
    @time = Time.now
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
    @counter = session[:counter]
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else
      @products = Product.all
    end
  end
  def show
    @cart = current_cart
  	@product = Product.find(params[:id])
  end

  def cart_details
    @cart = current_cart
    
  end
end
