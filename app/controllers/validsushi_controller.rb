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
end
