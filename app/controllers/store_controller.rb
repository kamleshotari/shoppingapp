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
    @products = Product.where("category_id IN (?)", @category.pluck(:id)).order('title').page(params[:page]).per(6)
  end

  def show
    @cart = current_cart
  	@product = Product.find(params[:id])
  end

  def cart_details
    @cart = current_cart
    
  end
end
