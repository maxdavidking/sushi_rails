require 'rails_helper'

RSpec.describe "User features" do
  let(:create_users) do
    User.create!(name: "Max King", organization: "IIT")
    User.create!(name: "test", organization: "test")
  end
  let(:view_users) do
    visit('/')
    click_link('User Profile')
  end

  describe "List user information" do
    it "lists all user profiles" do
      create_users
      view_users
      expect(page).to have_content('Max King')
    end
  end
  describe "Add user information" do
    it "allows users to create a profile" do
      user = User.create!(name: "Brian", organization: "IIT")

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
      create_users
      view_users
      first(:link, 'Edit Profile').click
      #fill_in 'Name', with: "Adam"
      expect(page).to have_content('Adam')
    end
  end
end
