# frozen_string_literal: true

class SushiController < ApplicationController
  def index
    # Check user has correct org permissions
    if member_of_org?
      @sushi = Sushi.order(:name).where(organization_id: current_organization.id)
    else
      redirect_to "/organizations"
    end
  end

  def new
    # Check user has correct org permissions
    if member_of_org?
      @validsushi = Validsushi.order(:name)
      @sushi = Sushi.new
    else
      redirect_to "/organizations"
    end
  end

  def create
    @sushi = Sushi.new(sushi_params)
    if @sushi.save
      redirect_to("/sushi")
    else
      flash[:danger] = "Error: #{@sushi.errors.full_message(@sushi.name, 'already exists')}"
      redirect_to "/sushi/new"
    end
  end

  def edit
    @sushi = Sushi.find(params[:id])
    unless session[:user_id] == @sushi.user_id || current_organization.id = @sushi.organization_id
      flash[:danger] = "That's not your sushi connection"
      redirect_to root_path and return
    end
  end

  def update
    @sushi = Sushi.find(params[:id])
    @sushi.update(sushi_params)
    if @sushi.save
      flash[:success] = "#{@sushi.name} updated"
      redirect_to("/sushi")
    end
  end

  def test
    @sushi = Sushi.find(params[:id])
    @response = helpers.sushi_call(@sushi)
    @error = helpers.error
    unless session[:user_id] == @sushi.user_id || current_organization.id = @sushi.organization_id
      flash[:danger] = "That's not your sushi connection"
      redirect_to root_path and return
    end
  end

  def call
    @organization = current_organization
    @sushi = Sushi.find(params[:id])
    # Ensure user can only access their own connections
    unless session[:user_id] == @sushi.user_id || current_organization.id == @sushi.organization_id
      flash[:danger] = "That's not your sushi connection"
      redirect_to root_path and return
    end
    begin
      CounterWorker.perform_async(@sushi.id, @organization.id)
      redirect_to("/sushi")
      flash[:info] = %Q[Please be patient, this can take a few minutes. When
          finished, your report will go to the #{view_context.link_to 'Settings', user_index_path}
          tab]
    rescue StandardError
      redirect_to("/sushi")
      flash[:danger] = "Failure, try testing your connection"
    end
  end

  def destroy
    @sushi = Sushi.find(params[:id])
    unless current_organization.id == @sushi.organization_id
      flash[:danger] = "That's not your sushi connection"
      redirect_to root_path and return
    end
    @sushi.destroy
    respond_to do |format|
      format.html { redirect_to("/sushi") }
      format.json { head :no_content }
    end
  end

  def sushi_params
    params.require(:sushi).permit(:name, :endpoint, :cust_id, :req_id, :report_start, :report_end, :password, :organization_id)
  end
end
