class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = @user.id
    flash[:success] = "Welcome, #{@user.name}"
    redirect_to root_path
  end

  def destroy
    if current_user
      session.delete(:user_id)
    end
    flash[:success] = "Authentication failed."
    redirect_to root_path
  end
end
