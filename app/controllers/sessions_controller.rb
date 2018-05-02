class SessionsController < ApplicationController
  def create
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}"
      if current_organization == nil
        redirect_to organizations_path
      else
        redirect_to root_path
      end
    rescue
      flash[:danger] = "FetchCounter only works with non-instutional gmail accounts. Please use your personal gmail account."
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
