class SushiController < ApplicationController

  def index
    @sushi = Sushi.all
  end

  def new
    @sushi = Sushi.new
  end

  def create
    sushi = Sushi.new(sushi_params)
    sushi.save
    redirect_to('/sushi')
  end

  def edit
    @sushi = Sushi.find(params[:id])
  end

  def update
    @sushi = Sushi.find(params[:id])
    if @sushi.update_attributes(sushi_params)
      redirect_to('/sushi')
    else
      render 'edit'
    end
  end

  def destroy
    @sushi = Sushi.find(params[:id])
    @sushi.destroy
    redirect_to('/sushi')
  end
  def sushi_params
    params.require(:sushi).permit(:name, :endpoint, :cust_id, :req_id, :report_start, :report_end, :password)
  end
end
