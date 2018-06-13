class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_organization
    @current_organization = current_user.organization
  end

  def signed_in?
    !!current_user
  end

  def member_of_org?
    !!current_organization
  end

  def sushi_update(organization)
    user = current_user
    user.update(organization_id: organization.id)
    sushi = Sushi.where(user_id: current_user)
    sushi.update_all(organization_id: organization.id)
  end

  def delete_orgs
    organizations = Organization.all
    organizations.each do |o|
      if o.users.empty?
        o.destroy
      end
    end
  end

  def delete_data
    Datum.where("created_at < ?", 1.month.ago).destroy_all
  end

  def org_access_rights?(organization)
    unless current_organization.id == organization.id
      flash[:danger] = "That's not your organization"
      redirect_to root_path
      return
    end
  end

  def user_access_rights?(user)
    unless session[:user_id] == user.id
      flash[:danger] = "That's not your user page"
      redirect_to root_path
      return
    end
  end

  helper_method :user_access_rights?
  helper_method :org_access_rights?
  helper_method :delete_data
  helper_method :delete_org?
  helper_method :sushi_update
  helper_method :current_organization
  helper_method :current_user
  helper_method :signed_in?
  helper_method :member_of_org?
end
