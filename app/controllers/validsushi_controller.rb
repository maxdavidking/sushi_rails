class ValidsushiController < ApplicationController
  def index
    @validsushi = Validsushi.all
  end

  def import
    @validsushi = Validsushi.find(params[:id])
    @sushi = Sushi.new(name: @validsushi.name, endpoint: @validsushi.endpoint, cust_id: @validsushi.cust_id, req_id: @validsushi.req_id, report_start: @validsushi.report_start, report_end: @validsushi.report_end, password: @validsushi.password, user_id: current_user.id )
    if @sushi.save
      redirect_to('/sushi')
    else
      flash[:danger] = "Error: #{@sushi.errors.full_messages}"
      redirect_to ('/validsushi')
    end
  end

  def new
    @validsushi = Validsushi.new
  end

  def create
    @validsushi = Validsushi.new(validsushi_params)
    if @validsushi.save
      redirect_to('/validsushi')
    else
      flash[:danger] = "Error: #{@validsushi.errors.full_messages}"
      redirect_to ('/validsushi/new')
    end
  end

  def validsushi_params
    params.require(:validsushi).permit(:name, :endpoint, :cust_id, :req_id, :report_start, :report_end, :password)
  end

end
