class UserController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :set_cache_headers

  def index
    # Check user has correct org permissions
    if member_of_org?
      @user = User.find_by(id: session[:user_id])
      @data = Datum.order(created_at: :desc).where(organization_id: current_organization.id)
      user_access_rights?(@user)
    else
      redirect_to "/organizations"
    end
  end

  def edit
    @user = User.find(params[:id])
    user_access_rights?(@user)
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.save
    redirect_to("/user")
  end

  def update
    if current_organization.nil?
      redirect_to("/organizations")
    else
      @user.update(user_params)
      redirect_to("/user")
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :organization_id)
  end

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
