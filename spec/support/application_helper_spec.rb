module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(session[:user_id])
  end
  def create_session
    session[:user_id] = @user.id
  end
end
