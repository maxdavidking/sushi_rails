class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json
  def index
    @organization = Organization.all
    #Force users to join an org if not already in one
    render :layout => "organization_lock"
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    @organization = Organization.find(params[:id])
    @users = User.where(organization_id: current_organization.id)
    unless current_organization.id == @organization.id
      flash[:danger] = "That's not your organization"
      redirect_to root_path
      return
    end
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
    #Force users to join an org if not already in one
    render :layout => "organization_lock"
  end

  # GET /organizations/1/edit
  def edit
    @organization = Organization.find(params[:id])
    unless current_organization.id == @organization.id
      flash[:danger] = "That's not your organization"
      redirect_to root_path
      return
    end
  end

  def join
    @organization = Organization.find(params[:id])
    #Force users to join an org if not already in one
    render :layout => "organization_lock"
  end

  def add_org_to_user
    @organization = Organization.find(params[:id])
    if current_user.organization_id != nil
      redirect_to('/user')
      flash[:danger] = "Error: You are already a member of an organization"
    elsif
      @organization.authenticate(organization_params[:password]) == false
      redirect_to('/organizations')
      flash[:danger] = "Wrong password"
    else
      current_user.update_attributes(organization_id: @organization.id)
      redirect_to('/user')
      flash[:success] = "Welcome to #{@organization.name}"
    end
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      user = current_user
      user.update(organization_id: @organization.id)
      helpers.org_folder?(@organization.name)
      redirect_to('/user')
    elsif organization_params[:password] != organization_params[:password_confirmation]
      flash[:danger] = "Error: passwords must match"
      redirect_to ('/organizations/new')
    else
      flash[:danger] = "Error: #{@organization.errors.full_message(@organization.name, 'already exists')}"
      redirect_to ('/organizations/new')
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    @organization.update_attributes(organization_params)
    redirect_to('/user')
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :email, :password, :password_confirmation)
    end
end
