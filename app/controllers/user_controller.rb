class UserController < ApplicationController
  def index
    @user = User.all
  end
  def edit
    @user = User.find(params[:id])
    @user.update(name: "Adam" )
  end
  def new
    @user = User.new
  end
  def create
    user = User.new(user_params)
    user.save
    redirect_to('/user')
  end

  private
  def user_params
    params.require(:user).permit(:name, :organization)
  end
end
