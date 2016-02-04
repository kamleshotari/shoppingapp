class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  

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
      store_index_url
    end
  end

  def after_sign_in_path_for(resource)
    
    if current_user.is_admin == true
      products_url
    else
      "/store"
    end
  end
  # def set_i18n_locale_from_params
  #     if params[:locale]
  #       if I18n.available_locales.include?(params[:locale].to_sym)
  #         I18n.locale = params[:locale]
  #       else
  #         flash.now[:notice] = 
  #           "#{params[:locale]} translation not available"
  #         logger.error flash.now[:notice]
  #       end
  #     end

  #   end

  #   def default_url_options
  #     { :locale => I18n.locale }
  #   end
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

end
