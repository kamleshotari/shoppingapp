module ApplicationHelper

	def resource_name
    :user
  end
 
  def resource
  	if user_signed_in?
  		@resource = current_user
  	else
    	@resource ||= User.new
    end
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def link_to_remove(address, f)
    f.hidden_field(:_destroy) + link_to_function(address, "remove_fields(this)")
  end
end
