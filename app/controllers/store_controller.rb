class StoreController < ApplicationController
  layout "user_layout"
  def index
    @category = Category.find_by_code(params[:code])
    @products = Product.where("category_id =?", @category.id)
  end
end
