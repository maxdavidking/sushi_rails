require 'rails_helper'

RSpec.describe "Organization controller" do
  let (:sign_in) do
    visit '/'
    mock_auth_hash
    click_link "Login"
    Organization.create!(id: 99, name: "test123", password: "test", email: "test@example.com")
  end

  describe "Organization Features", :type => :feature do
    include ApplicationHelper
    it "can create a new organization after logging in with OAuth" do
      sign_in
      visit("/organizations")
      click_link "New Organization"
      fill_in "Name", with: "test"
      fill_in "Password", with: "test"
      fill_in "Confirm Password", with: "test"
      fill_in "Email", with: "test@example.com"
      click_button('Create')
      expect(page).to have_content('test')
    end

    it "updates the user table when a user joins an organization" do
      sign_in
      visit("/organizations")
      click_link "Join"
      fill_in "organization_password", with: "test"
      click_button("Confirm")
      expect(page).to have_content("test123")
    end

    it "updates the user table when a user creates an organization" do
      sign_in
      visit("/user")
      expect(page).not_to have_content('test')
      visit("/organizations")
      click_link "New Organization"
      fill_in "Name", with: "test"
      fill_in "Password", with: "test"
      fill_in "Confirm Password", with: "test"
      fill_in "Email", with: "test@example.com"
      click_button("Create")
      expect(page).to have_content('test')
    end

    it "can not join an existing organization without the correct password" do
      sign_in
      visit("/organizations")
      click_link "Join"
      fill_in "organization_password", with: "hello"
      click_button("Confirm")
      expect(page).to_not have_content("test")
      expect(page).to have_content("Wrong password")
    end

    it "can edit name of an existing organization if part of that organization" do
      sign_in
      Organization.create!(id: 100, name: "IIT", password: "test", email: "test@example.com")
      current_user.update(organization_id: 100)
      visit("/user")
      expect(page).to have_content("IIT")
      click_link("Edit Organization")
      fill_in "Name", with: "hello"
      click_button("Update")
      expect(page).to have_content("hello")
    end

    it "can not edit name of an existing organization if not part of that organization" do
      sign_in
      Organization.create!(id: 100, name: "IIT", password: "test", email: "test@example.com")
      Organization.create!(id: 101, name: "max", password: "test", email: "test@example.com")
      current_user.update(organization_id: 101)
      visit("/user")
      expect(page).to_not have_content('IIT')
      visit("/organizations/100/edit")
      expect(page).to have_content("That's not your organization")
    end

    it "can list all users for the current organization" do
      sign_in
      Organization.create!(id: 100, name: "IIT", password: "test", email: "test@example.com")
      User.create!(id: 100, name: "Max", uid: 100, provider: "google", organization_id: 100)
      User.create!(id: 101, name: "Joe", uid: 101, provider: "google", organization_id: 100)
      current_user.update(organization_id: 100)
      visit("/user")
      click_link("IIT")
      expect(page).to have_content("Joe")
      expect(page).to have_content("Max")
      expect(page).to have_content("mockuser")
    end

    it "can encrypt Organization password with bcrypt" do
      sign_in
      visit("/organizations")
      click_link "New Organization"
      fill_in "Name", with: "test"
      fill_in "Password", with: "test"
<<<<<<< HEAD
      fill_in "Confirm Password", with: "test"
=======
>>>>>>> Add test to validate password_digest not being stored as plain text
      fill_in "Email", with: "test@example.com"
      click_button('Create')
      org = Organization.find(99)
      org_pw = org.password_digest
      expect(org_pw).not_to eq("test")
    end

    it "can leave Organizations successfully" do
      sign_in
      visit("/organizations")
      click_link "Join"
      fill_in "organization_password", with: "test"
      click_button("Confirm")
      click_link("Edit Profile")
      click_button("Leave Organization")
    end

    it "creates a directory in /public/ for the organization if the org doesn't already have one" do
      sign_in
      visit("/organizations")
      click_link "Join"
      fill_in "organization_password", with: "test"
      click_button("Confirm")
      expect(File).not_to exist("#{Rails.root}/public/test123")
      Sushi.create!(name: "jstor", endpoint: "https://www.jstor.org/sushi", cust_id: "iit.edu", req_id: "galvinlib", report_start: "2016-01-01", report_end: "2016-12-31", password: "", user_id: current_user.id, organization_id: current_organization.id)
      visit('/sushi')
      first(:link, "Get CSV Counter Report").click
      expect(File).to exist("#{Rails.root}/public/test123")
    end

    it "creates a directory in /public/ for the organization on org creation" do
      sign_in
      expect(File).not_to exist("#{Rails.root}/public/test1")
      visit("/organizations")
      click_link "New Organization"
      fill_in "Name", with: "test1"
      fill_in "Password", with: "test"
      fill_in "Confirm Password", with: "test"
      fill_in "Email", with: "test@example.com"
      click_button('Create')
      expect(File).to exist("#{Rails.root}/public/test1")
    end
  end
end
