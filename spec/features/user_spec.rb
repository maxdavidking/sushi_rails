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

  describe "Edit user information" do
    it "allows users to edit their profiles" do
      create_users
      view_users
      first(:link, 'Edit Profile').click
      expect(page).to have_content('Adam')
    end
  end
end
