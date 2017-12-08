require 'rails_helper'

RSpec.describe "Home page features" do
  let(:view_user) do
    visit('/')
    click_link('Google')
  end
  describe "Log in and display user name" do
      it "shows the user name of the logged in user" do
        User.create!(name: "David King", organization: "IIT", uid: "0001", provider: "google")

        view_user
        expect(page).to have_content "Edit Profile"
      end
  end
end
