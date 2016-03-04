class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  add_flash_types :success, :warning, :danger, :info
  before_action :initialize_omniauth_state


  def authenticate_admin
  	if user_signed_in? and current_user.is_admin?
  		return true
  	else
  		sign_out current_user
  		redirect_to "/"
  	end
  end

  def after_sign_up_path_for(resource)
    if current_user.is_admin
      products_url
    else
      "/store"
    end
  end

  def after_sign_in_path_for(resource)
    
    if current_user.is_admin == true
      products_url
    else
      "/store"
    end
  end

  def after_update_path_for(resource)
    current_user.update(user_params)
    current_user.addresses.build
    if current_user.is_admin == true
      users_url
    else
      "/store/current_user_details"
    end
  end
  
  protected
   def current_cart 
    cart = Cart.where("id =?", session[:cart_id]).last
    line_items = cart.present? && cart.line_items.present? ? cart.line_items.count : 0
    
    if cart.blank? || line_items == 0
      if user_signed_in?
        cart = Cart.where("user_id =?", current_user.id).last
        cart = Cart.create(:user_id => current_user.id) if cart.blank?
      else
        cart = Cart.create
      end
    else
      if user_signed_in? && cart.user_id.nil?
        cart.update_attributes(:user_id => current_user.id)
      end
    end
    session[:cart_id] = cart.id
    cart
   end
   def initialize_omniauth_state
    session['omniauth.state'] = response.headers['X-CSRF-Token'] = form_authenticity_token
   end

   def user_params
    params.require(:user).permit(:id,:first_name, :last_name, :email, :address, :country, :phone_number, addresses_attributes: [:id, :address,:city,:state,:zip_code,:country,:contact_number, :_destroy])
  end

end
