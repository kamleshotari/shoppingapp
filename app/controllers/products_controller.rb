class ProductsController < ApplicationController
  before_filter :authenticate_admin
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
    @products = Product.page(params[:page]).per(5)
  end
  

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @product = Product.find(params[:id])
   
  end

  def edit
    @product = Product.find(params[:id])
  end
  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update_attributes(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:id, :title, :description, :price, :category_id, :uniq_code, :code, :color, :image)
    end
  
end
