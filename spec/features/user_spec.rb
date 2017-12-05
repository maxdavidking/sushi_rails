require 'rails_helper'

RSpec.describe "User features" do
  describe "List user information" do
    it "lists all user profiles" do
      User.create!(name: "Max King", organization: "IIT")

      visit('/')
      click_link('User Profile')

      expect(page).to have_content('Max King')

    end
  end
end
