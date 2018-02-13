class SessionsController < ApplicationController
  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}"
      redirect_to root_path
    rescue
      flash[:danger] = "FetchCounter only works with gmail accounts"
      redirect_to root_path
    end
  end

  def destroy
    if current_user
      session.delete(:user_id)
    end
    flash[:success] = "Logged out"
    redirect_to root_path
  end
end
