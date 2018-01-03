class SushiController < ApplicationController
  def index
    @sushi = Sushi.where(user_id: session[:user_id])
  end

  def new
    @sushi = Sushi.new
  end

  def create
    @sushi = Sushi.new(sushi_params)
    if @sushi.save
      render json: @sushi
    else
      render json: @sushi.errors, status: :unprocessable_entity
    end
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

  def test
    @sushi = Sushi.find(params[:id])
    @response = helpers.sushi_call
  end

  def call
    @sushi = Sushi.find(params[:id])
    begin
      helpers.sushi_call
      helpers.months_math(@sushi.report_start, @sushi.report_end)
      helpers.count_months
      respond_to do |format|
        format.html
        format.csv { send_data helpers.csv_open, filename: "#{@sushi.name}-#{Date.today}.csv" }
      end
    rescue
      redirect_to action: "index"
      flash[:error] = "Failure, try testing your connection"
    end
  end

  def destroy
    @sushi = Sushi.find(params[:id])
    @sushi.destroy
    redirect_to('/sushi')
  end
  def sushi_params
    params.require(:sushi).permit(:name, :endpoint, :cust_id, :req_id, :report_start, :report_end, :password, :user_id)
  end
end
