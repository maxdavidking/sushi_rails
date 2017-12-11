require 'rails_helper'

RSpec.describe "User features" do
  let(:create_user) do
    @user = User.create!(id: 100, name: "Brian", organization: "test", uid: "0001111", provider: "google")
    @user.save
  end
  let(:view_user) do
    visit('/user/100/edit')
  end

  describe "List user information" do
    it "lists one user profile data" do
      create_user
      view_user
      expect(page).to have_content('Organization')
    end
  end

  describe "Edit user information" do
    it "allows users to edit their profiles" do
      create_user
      view_user
      expect(page).to have_content('Organization')

      expect(page).to have_content('Edit')


    end
  end
end
