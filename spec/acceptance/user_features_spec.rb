require "rails_helper"

RSpec.describe "User features" do
  before(:each) do
    sign_in
  end

  describe "User login actions", type: :feature do
    it "lists logged in user's profile data" do
      join_org
      visit("/user")
      expect(page).to have_content("mockuser")
    end

    it "forces user to create an organization if they don't already have one" do
      # Sanity check
      expect(page).to have_content("New Organization")
      join_org
      expect(page).to_not have_content("COUNTER Connections")
    end
  end
end
