require "rails_helper"

RSpec.describe SushiController do
  describe "Sushi Controller Tests" do
    let(:create_user_org_pair) do
      @user = create(:user, organization_id: 101)
      @organization = create(:organization, id: 101)
      session[:user_id] = @user.id
    end
    let(:sushi_attributes) do
      @sushi_attributes = attributes_for(:sushi)
    end
    # To get access to session variables with current_user and current_org
    include ControllerHelper
    describe "DELETE #destroy" do
      context "it destroys the record" do
        it "has one less Sushi record" do
          create_user_org_pair
          sushi = create(:sushi, organization_id: @organization.id)
          expect{
            delete :destroy,
            params: {id: sushi.id}
          }.to change{Sushi.count}.by(-1)
        end
      end
      context "the organization_id is not correct" do
        it "flashes a warning message" do
          create_user_org_pair
          sushi = create(:sushi, organization_id: 100)
          delete :destroy, params: { id: sushi.id }
          # Sanity check
          expect(current_organization.id).to eq(101)
          expect(flash[:danger]).to eq("That's not your sushi connection")
        end
      end
    end
    describe "PATCH/PUT :id/#edit" do
      context "user is able to edit this record" do
        it "gets the correct Sushi record information" do
          create_user_org_pair
          sushi = create(:sushi, organization_id: 100)
          # put :edit, params: {id: sushi.id, sushi: sushi}
          pending "Need to work with Ajax render of page"
        end
      end
      context "user is unable to edit this record" do
        it "flashes a warning message" do
          create_user_org_pair
          sushi = create(:sushi, organization_id: 100)
          # put :edit, params: {id: sushi.id, sushi: sushi}
          pending "Need to work with Ajax render of page"
        end
        it "redirects to the root_path" do
          create_user_org_pair
          sushi = create(:sushi, organization_id: 100)
          # put :edit, params: {id: sushi.id, sushi: sushi}
          pending "Need to work with Ajax render of page"
        end
      end
    end
    describe "POST #new" do
      context "the user can create because they are a member of an org" do
        it "renders the new sushi form" do
          create_user_org_pair
          sushi_attributes
          get :new
          expect(response).to render_template("new")
        end
      end
      context "the user is not able to create" do
        it "redirects to /organizations" do
          @user = create(:user, organization_id: nil)
          session[:user_id] = @user.id
          get :new
          expect(response).to have_http_status(302)
        end
      end
    end
    describe "GET #call" do
      context "it calls the SUSHI API" do
        pending "moving #call to ServiceObject, test most functionality there"
      end
      context "it does not call the SUSHI API" do
        pending "moving #call to ServiceObject, test most functionality there"
      end
    end
    describe "GET #test" do
      context "it tests the SUSHI API" do
        pending "moving #test to ServiceObject, test most functionality there"
      end
      context "it does not test the SUSHI API" do
        pending "moving #test to ServiceObject, test most functionality there"
      end
    end
    describe "PATCH/PUT #update/:id" do
      context "it saves the update to the record" do
        it "changes the sushi attributes" do
          create_user_org_pair
          sushi = create(:sushi, organization_id: @organization.id)
          # Sanity check
          expect(sushi.name).to eq("jstor")
          params = {name: "ACM"}
          put :update, params: {id: sushi.id, sushi: params}
          sushi.reload
          expect(sushi.name).to eq("ACM")
        end
        it "flashes a success message" do
          create_user_org_pair
          # Sanity check
          expect(flash[:success]).to eq(nil)
          sushi = create(:sushi, organization_id: @organization.id)
          params = {name: "ACM"}
          put :update, params: {id: sushi.id, sushi: params }
          expect(flash[:success]).to include("updated")
        end
        it "redirects to /sushi" do
          create_user_org_pair
          sushi = create(:sushi, organization_id: @organization.id)
          params = {name: "ACM"}
          put :update, params: {id: sushi.id, sushi: params }
          expect(response).to have_http_status(302)
        end
      end
    end
    describe "POST #create" do
      context "saves the created record" do
        it "changes the total number of sushi records" do
          create_user_org_pair
          sushi_attributes
          expect{
            post :create,
            params: { sushi: @sushi_attributes}
          }.to change{Sushi.count}.by(1)
        end
        it "redirects to /sushi" do
          create_user_org_pair
          sushi_attributes
          post :create, params: { sushi: @sushi_attributes}
          expect(response).to have_http_status(302)
        end
      end
      context "it does not save the created record" do
        it "flashes a warning message" do
          create_user_org_pair
          sushi_attributes
          # Sanity check
          expect(flash[:danger]).to eq(nil)
          # Try to make it twice to get an error
          post :create, params: { sushi: @sushi_attributes}
          post :create, params: { sushi: @sushi_attributes}
          expect(flash[:danger]).to include("Error:")
        end
        it "redirects to /sushi/new" do
          create_user_org_pair
          sushi_attributes
          # Try to make it twice to get an error
          post :create, params: { sushi: @sushi_attributes}
          post :create, params: { sushi: @sushi_attributes}
          expect(response).to have_http_status(302)
        end
      end
    end
    describe "GET #index" do
      context "user is in a organization" do
        it "renders all sushi records alphabetically" do
          create_user_org_pair
          get :index
          expect(response).to render_template("index")
        end
      end
      context "user is not in an organization" do
        it "redirects to /organizations" do
          @user = create(:user, organization_id: nil)
          session[:user_id] = @user.id
          get :index
          expect(response).to have_http_status(302)
        end
      end
    end
  end
end
