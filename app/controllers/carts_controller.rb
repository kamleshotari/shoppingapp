class CartsController < ApplicationController                 
  #before_filter :authenticate_admin
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
  # GET /carts
  # GET /carts.xml
  def index
    @carts = Cart.all
    @carts = Cart.page(params[:page]).per(5)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @carts }
    end
    @cart.remove_item params[:id], session[:cart_item]
  end

  # GET /carts/1
  # GET /carts/1.xml
  def show
    begin

      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to store_url, :notice => 'Invalid cart'
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @cart }
      end
    end
  end

  # GET /carts/new
  # GET /carts/new.xml
  def new
    @cart = Cart.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.xml
  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        
        format.html { redirect_to(@cart, :notice => 'Cart was successfully created.') }
        format.xml  { render :xml => @cart, :status => :created, :location => @cart }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.xml
  def update
    @cart = Cart.find(params[:id])

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to(@cart, :notice => 'Cart was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.xml
  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil

    @cart = current_cart
    respond_to do |format|
      format.js
    end
  end
  
  private
  def set_cart
      @cart = Cart.find(params[:id])
    end
end