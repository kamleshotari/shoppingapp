class StoreController < ApplicationController
  layout "user_layout"
  skip_before_filter :authenticate_user!
  
  def index
    
    @cart = current_cart
    @products = Product.search(params).page(params[:page]).per(6)

  	if params[:code].present?
    	@category = Category.where('code = ?', params[:code])
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
  
  def current_user_details
    @cart = current_cart
    @user = current_user
  end
  def error
    @cart = current_cart
  end
end
