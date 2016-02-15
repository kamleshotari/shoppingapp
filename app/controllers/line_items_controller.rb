class LineItemsController < ApplicationController        
  skip_before_filter :authenticate_user!, :only => :create
  
  # GET /line_items
  # GET /line_items.xml
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.xml
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.xml
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.xml
  # POST /line_items
   # POST /line_items.xml
   def create
     @cart = current_cart
     product = Product.find(params[:product_id])
     @line_item = @cart.add_product(product.id)
     #@line_item.user = current_user
     respond_to do |format|
       if @line_item.save
         format.html { redirect_to(store_url)  }
         format.js
         format.xml  { render :xml => @line_item,
           :status => :created, :location => @line_item }
       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @line_item.errors,
           :status => :unprocessable_entity }
       end
     end
   end

  # PUT /line_items/1
  # PUT /line_items/1.xml
  def update
    @line_item = LineItem.find(params[:id])
    respond_to do |format|
      if @line_item.update_attributes(line_item_params)
        format.html { redirect_to(@line_item, :notice => 'Line item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.xml
  def destroy
    
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    @cart = current_cart
    respond_to do |format|
      format.js
    end   
  end

  private
    def line_item_params
      params.require(:line_item).permit(:product_id, :cart_id, :order_id, :quantity)
    end
end