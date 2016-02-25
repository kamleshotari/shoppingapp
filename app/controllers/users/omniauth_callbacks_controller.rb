class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token

	def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  def google_oauth2
     
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
 
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    user = User.create(first_name: data["first_name"],
      email: data["email"],
      password: Devise.friendly_token[0,20]
      )
    user
  end

  def failure
    redirect_to root_path
  end

end
