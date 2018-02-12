require 'rails_helper'

RSpec.describe "User features" do
  include ApplicationHelper
  let (:sign_in) do
    visit '/'
    mock_auth_hash
    click_link "Google"
  end

  describe "User login actions", :type => :feature do
    it "lists logged in user's profile data" do
      sign_in
      click_link "User Profile"
      expect(page).to have_content('mockuser')
    end
    it "allows users to edit their profiles" do
      sign_in
      click_link "User Profile"
      click_link "Edit Profile"
      expect(page).to have_content('Organization')
      fill_in 'Organization', :with => "IIT"
      click_button "Update"
      expect(page).to have_content('IIT')
    end
  end
end
