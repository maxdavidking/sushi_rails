require 'rails_helper'

RSpec.describe "User features" do
  let(:create_users) do
    User.create!(name: "David King", organization: "IIT", uid: "0001", provider: "google")
    User.create!(name: "test123", organization: "test", uid: "0001111", provider: "google")
  end
  let(:view_users) do
    visit('/')
    click_link('User Profile')
  end

  describe "List user information" do
    it "lists all user profiles" do
      create_users
      view_users
      expect(page).to have_content('David King')
    end
  end

  describe "Add user information" do
    it "allows users to create a profile" do
      user = User.create!(name: "Brian", organization: "IIT", uid: "0001110", provider: "google")

      view_users
      click_link('Create Profile')
      fill_in 'Name', with: user.name
      fill_in 'Organization', with: user.organization
      click_on('Create')
      visit('/user')

      expect(page).to have_content "#{user.name}"
    end
  end

  describe "Edit user information" do
    it "allows users to edit their profiles" do
      user = User.create!(name: "Brian", organization: "IIT", uid: "0001110", provider: "google")

      create_users
      view_users
      first(:link, 'Edit Profile').click
      fill_in 'Name', with: "#{user.name}"
      click_on('Edit')

      visit('/user')
      expect(page).to have_content "#{user.name}"

    end
  end
end
