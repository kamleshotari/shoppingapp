class ProductImportController < ApplicationController

  def new
  	
  end

  def create
  	@import_response = Product.import(params[:file])
    respond_to do |format|
    	#format.js
    	format.html{redirect_to URI.encode("/product_import/new?s=#{@import_response.first.join(', ')}&f=#{@import_response.last.join(', ')}"), :notice => "Products imported successfully"}
    end
  end
end
