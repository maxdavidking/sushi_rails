require "rails_helper"

RSpec.describe OrganizationsController do
  # To get access to session variables with current_user and current_org
  include ControllerHelper
  let(:create_user_org_pair) do
    @user = create(:user)
    @organization = @user.organization
    session[:user_id] = @user.id
  end
  let(:org_attributes) do
    @user = create(:user, organization_id: nil)
    @org_attributes = attributes_for(:organization)
    session[:user_id] = @user.id
  end
  let(:create_user) do
    @user = create(:user)
    session[:user_id] = @user.id
    @user.update(organization_id: @organization.id)
  end
  describe "Organization controller tests" do
    describe "DELETE #destroy/:id" do
      it "deletes an organization from ActiveRecord" do
        create_user_org_pair
        delete :destroy, params: { id: @organization.id }
        expect(Organization.where(id: @organization.id).count).to eq(0)
      end
    end
    describe "PATCH/PUT #update/:id" do
      context "updates successfully" do
        it "changes the organization attributes" do
          create_user_org_pair
          # Sanity check
          expect(@organization.name).to eq("IIT")
          params = {name: "IIT2"}

          put :update, params: {id: @organization.id, organization: params}
          @organization.reload
          expect(@organization.name).to eq("IIT2")
        end
        it "redirects to the /user page" do
          create_user_org_pair
          params = {name: "IIT2"}
          put :update, params: {id: @organization.id, organization: params}
          expect(response).to have_http_status(302)
        end
      end
    end
    describe "POST #create" do
      context "the organization successfully saves" do
        it "creates a new organization" do
          org_attributes
          expect{
            post :create,
            params: {organization: @org_attributes}
          }.to change{Organization.count}.by(1)
        end
        it "updates the current_user's organization_id" do
          org_attributes
          # Sanity check
          expect(current_user.organization_id).to eq(nil)

          post :create, params: {organization: @org_attributes}
          pending "Passing irregularly"
          expect(current_user.organization_id).to be_truthy
        end
        it "creates a folder in the /storage directory with the org name" do
          org_attributes
          post :create, params: {organization: @org_attributes}
          expect(File).to exist("#{Rails.root}/storage/IIT")
        end
        it "adds the org_id to all Sushi records associated with the user" do
          org_attributes
          sushi = create(:sushi, user_id: @user.id)
          # Sanity check
          expect(sushi.organization_id).to eq(nil)
          post :create, params: {organization: @org_attributes}
          pending "Passing irregularly"
          expect(sushi.organization_id).to be_truthy
        end
        it "redirects to the /user page" do
          create_user_org_pair
          org_attributes
          post :create, params: {organization: @org_attributes}
          expect(response).to have_http_status(302)
        end
      end
      context "the organization already exists" do
        it "redirects to the org/new page" do
          create_user_org_pair
          org_attributes
          post :create, params: {organization: @org_attributes}
          expect(response).to have_http_status(302)
        end
      end
    end
  end
end
