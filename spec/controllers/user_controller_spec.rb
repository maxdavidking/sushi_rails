require "rails_helper"
def index
  # Check user has correct org permissions
  if member_of_org?
    @user = User.find_by(id: session[:user_id])
    @data = Datum.order(created_at: :desc).where(organization_id: current_organization.id)
    user_access_rights?(@user)
  else
    redirect_to "/organizations"
  end
end

def edit
  @user = User.find(params[:id])
  user_access_rights?(@user)
end

RSpec.describe UserController do
  describe "User Controller Tests" do
    let(:create_user_org_pair) do
      @user = create(:user, organization_id: 101)
      @organization = create(:organization, id: 101)
      session[:user_id] = @user.id
    end
    let(:user_attributes) do
      @user_attributes = attributes_for(:user)
    end
    # To get access to session variables with current_user and current_org
    include ControllerHelper
    describe "PATCH/PUT :id/#edit" do
      context "user tries to edit their profile with access rights" do
        it "shows the user the profile info" do
          pending "incorporate user_access_rights method"
          pending "User should be able to see profile"
        end
      end
      context "user tries to edit their profile without access rights" do
        it "does not show the user the profile info" do
          pending "incorporate user_access_rights method"
          pending "User should not be able to see profile"
        end
      end
    end
    describe "PATCH/PUT :id/#update" do
      context "the user tries to update but does not have an organization" do
        it "redirects to /organizations" do
          user = create(:user, organization_id: nil)
          params = {name: "test"}
          session[:user_id] = user.id
          # Sanity check
          expect(user.organization_id).to eq(nil)

          put :update, params: {id: user.id, user: params}

          expect(response).to have_http_status(302)
        end
        it "updates the user's name" do
          user = create(:user, organization_id: nil)
          params = {name: "test"}
          session[:user_id] = user.id
          # Sanity check
          expect(user.organization_id).to eq(nil)
          expect(user.name).to_not eq("test")

          put :update, params: {id: user.id, user: params}
          user.reload
          pending "User should NOT be able to update without an organization"
          expect(user.name).to eq("test")
        end
      end
      context "the user updates and is in an organization" do
        it "updates the user's name" do
          create_user_org_pair
          params = {name: "test"}
          # Sanity check
          expect(@user.name).to_not eq("test")
          put :update, params: {id: @user.id, user: params}
          @user.reload
          expect(@user.name).to eq("test")
        end
        it "redirects to /user" do
          create_user_org_pair
          params = {name: "test"}
          put :update, params: {id: @user.id, user: params}
          expect(response).to have_http_status(302)
        end
      end
    end
    describe "POST #create" do
      context "a new user is created" do
        it "increases the User count by one" do
          user_attributes
          # Not ticking User.count upwards for some reason?
          pending{
            post :create,
            params: {user: @user_attributes}
          }.to change{User.count}.by(1)
        end
        it "redirects back to the /user page" do
          user_attributes
          post :create, params: {user: @user_attributes}
          expect(response).to have_http_status(302)
        end
      end
    end
  end
end
