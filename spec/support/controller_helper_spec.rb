module ControllerHelper
  def current_user
    @current_user ||= User.find_by(session[:user_id])
  end

  def current_organization
    @current_organization = current_user.organization
  end
end
