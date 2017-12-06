class SushiController < ApplicationController
  def index
    @sushi = Sushi.all
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
  def sushi_params
    params.require(:sushi).permit(:name, :endpoint, :cust_id, :req_id, :report_start, :report_end, :password)
  end
end
