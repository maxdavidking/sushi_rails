require 'rails_helper'

RSpec.describe 'OAuth logins' do
  describe "access top page", :type => :feature do
    include ApplicationHelper
    it "can sign in user with Google account" do
      visit '/'
      expect(page).to have_content("Login")
      mock_auth_hash
      click_link "Login"
      expect(page).to have_content("mockuser")  # user name
      expect(page).to have_content("Log Out")
    end

    it "can handle authentication error" do
      OmniAuth.config.mock_auth[:google] = :invalid_credentials
      visit '/'
      expect(page).to have_content("Login")
      click_link "Login"
      expect(page).to have_content('Logged out')
    end
  end
end
