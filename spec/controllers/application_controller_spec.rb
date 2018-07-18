require "rails_helper"

RSpec.describe "Helper Tests" do
  describe "Test helpers" do
    # To get access to session variables with current_user and current_org
    include ControllerHelper

    it "tests the current_user helper" do
      Organization.create!(id: 101, name: "test", email: "test@example.com", password: "test")
      @user = User.create!(id: 100, name: "Brian", organization_id: 101, uid: "0001111", provider: "google")
      expect(current_user.id).to eq(100)
    end
    it "tests the current_organization helper" do
      Organization.create!(id: 101, name: "test", email: "test@example.com", password: "test")
      @user = User.create!(id: 100, name: "Brian", organization_id: 101, uid: "0001111", provider: "google")
      expect(current_organization.id).to eq(101)
    end
  end
end
