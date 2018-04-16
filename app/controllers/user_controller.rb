class UserController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.find_by(id: session[:user_id])
    @data = Datum.where(organization_id: current_organization.id)
    unless session[:user_id] == @user.id
      flash[:danger] = "That's not your user page"
      redirect_to root_path
    end
  end

  def edit
    @user = User.find(params[:id])
    unless session[:user_id] == @user.id
      flash[:danger] = "That's not your user page"
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    user.save
    redirect_to('/user')
  end

  def update
    @user.update_attributes(user_params)
    if current_organization == nil
      redirect_to('/organizations')
    else
      redirect_to('/user')
    end
  end

  private
    def set_user
       @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:name, :organization_id)
    end
end
