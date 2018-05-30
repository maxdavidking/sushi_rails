class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = @user.id
    flash[:success] = "Welcome, #{@user.name}"
    if current_organization.nil?
      redirect_to organizations_path
    else
      redirect_to root_path
    end
  rescue StandardError
    flash[:danger] = "FetchCounter only works with non-instutional gmail accounts. Please use your personal gmail account."
    redirect_to root_path
  end

  def destroy
    session.delete(:user_id) if current_user
    flash[:success] = "Logged out"
    redirect_to root_path
  end
end
