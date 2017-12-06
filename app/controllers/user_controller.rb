class UserController < ApplicationController
  def index
    @user = User.all
  end
  def edit
    @user = User.find(params[:id])
    @user.update(name: "Adam" )
  end
end
