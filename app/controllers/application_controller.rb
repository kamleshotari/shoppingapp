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

end
