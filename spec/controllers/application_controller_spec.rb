require "rails_helper"

RSpec.describe "Helper Tests" do
  let(:sign_in) do
    Organization.create!(id: 101, name: "test", email: "test@example.com", password: "test")
    user = User.create!(id: 100, name: "Fake", organization_id: 101, uid: "0001111", provider: "google")
    session[:user_id] = user.id
  end

  describe "Helpers unit tests" do
    # To get access to session variables with current_user and current_org
    include ControllerHelper

    it "returns the current_user" do
      sign_in
      expect(current_user.id).to eq(100)
    end

    it "returns the current_organization" do
      sign_in
      expect(current_organization.id).to eq(101)
    end

    it "returns false when a user is not signed in" do
      expect(signed_in?).to eq(false)
    end

    it "returns true when a user is signed in" do
      sign_in
      expect(signed_in?).to eq(true)
    end
  end
end
