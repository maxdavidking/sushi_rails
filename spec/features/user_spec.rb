require 'rails_helper'

RSpec.describe "User features" do
  let(:view_users) do
    visit('/')
    click_link('User Profile')
  end
  describe "List user information" do
    it "lists all user profiles" do
      User.create!(name: "Max King", organization: "IIT")
      User.create!(name: "test", organization: "test")

      view_users

      expect(page).to have_content('Max King')

    end
  end
end
