require 'rails_helper'

RSpec.describe "User features" do
  include ApplicationHelper
  let (:sign_in) do
    visit '/'
    mock_auth_hash
    click_link "Login"
  end

  describe "User login actions", :type => :feature do
    it "lists logged in user's profile data" do
      sign_in
      click_link "User Profile"
      expect(page).to have_content('mockuser')
    end
  end
end
