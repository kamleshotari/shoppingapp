class StoreController < ApplicationController
  layout "user_layout"
  def index
  	if params[:code].present?
    	@category = Category.where(params[:code])
    else 
    	@category = Category.all
    end
    @products = Product.where("category_id IN (?)", @category.pluck(:id))
  end
  def show
  	@product = Product.find(params[:id])
  end
end
