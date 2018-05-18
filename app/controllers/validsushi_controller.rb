class ValidsushiController < ApplicationController
  def index
    @validsushi = Validsushi.order(:name)
  end

  def new
    @validsushi = Validsushi.find(params[:id])
    @sushi = Sushi.new
  end

  def import
    @validsushi = Validsushi.find(params[:id])
    @sushi = Sushi.new(name: @validsushi.name, endpoint: @validsushi.endpoint, cust_id: @validsushi.cust_id, req_id: @validsushi.req_id, report_start: @validsushi.report_start, report_end: @validsushi.report_end, password: @validsushi.password, organization_id: current_organization.id )
    if @sushi.save
      flash[:success] = "Added #{@validsushi.name}"
      redirect_to("/validsushi")
    else
      flash[:danger] = "Error: #{@sushi.errors.full_message(@validsushi.name, 'already exists.')}"
      redirect_to("/validsushi")
    end
  end
end
