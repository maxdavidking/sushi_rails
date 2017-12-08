require 'rails_helper'

RSpec.describe "User features" do
  let(:create_user) do
    User.create!(id: 100, name: "test123", organization: "test", uid: "0001111", provider: "google")
  end
  let(:view_user) do
    visit('/user/100/edit')
  end
  describe "List user information" do
    it "lists one user profile data" do
      create_user
      view_user
      expect(page).to have_content('test123')
    end
  end

  describe "Edit user information" do
    it "allows users to edit their profiles" do
      current_user = User.create!(name: "Brian", organization: "IIT", uid: "0001110", provider: "google")
      create_user
      view_user
      expect(page).to have_content('test123')

      fill_in 'Name', with: "#{current_user.name}"
      click_on('Edit')

      visit('/user')
      expect(page).to have_content "#{current_user.name}"

    end
  end
end
