class UsersController < ApplicationController

  def index
  	@users = User.all
    @users = User.page(params[:page]).per(5)
  end

  

end
