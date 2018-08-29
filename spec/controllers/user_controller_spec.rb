require "rails_helper"

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
    describe "GET #index" do
      context "user is a member of an organization" do
        it "shows the user the profile info" do
          create_user_org_pair

          get :index

          expect(response).to render_template("index")
        end
      end
      context "user is not a member of an organization" do
        it "redirects to /organizations" do
          user = create(:user, organization_id: nil)
          session[:user_id] = user.id

          get :index

          expect(response).to have_http_status(302)
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
          expect(user.name).to_not eq("test")
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
  end
end
