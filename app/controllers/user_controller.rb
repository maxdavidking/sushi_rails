class UserController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.where(id: session[:user_id])
  end

  def edit
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
    if @user.update_attributes(user_params)
      redirect_to('/user')
    else
      render 'edit'
    end
  end

  private
    def set_user
       @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:name, :organization)
    end
end
