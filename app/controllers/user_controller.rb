class UserController < ApplicationController
  def index
    @user = User.all
  end
  def edit
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to('/user')
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :organization)
  end
end
