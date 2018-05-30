require "rails_helper"

RSpec.describe "User features" do
  include ApplicationHelper
  let (:sign_in) do
    visit "/"
    mock_auth_hash
    first(:link, "Login").click
    Organization.create!(id: 100, name: "IIT", password: "test", email: "test@example.com")
    current_user.update(organization_id: 100)
  end

  describe "User login actions", type: :feature do
    it "lists logged in user's profile data" do
      sign_in
      visit("/user")
      expect(page).to have_content("mockuser")
    end

    it "forces user to create an organization if they don't already have one" do
      sign_in
      expect(page).to have_content("New Organization")
      expect(page).to_not have_content("COUNTER Connections")
    end
  end
end
