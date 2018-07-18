require "rails_helper"

RSpec.describe "Organization controller" do
  before(:each) do
    sign_in
  end

  describe "Organization Features", type: :feature do
    it "can create a new organization after logging in with OAuth" do
      visit("/organizations")
      click_link "New Organization"
      fill_in "Name", with: "test"
      fill_in "Password", with: "test"
      fill_in "Confirm Password", with: "test"
      fill_in "Email", with: "test@example.com"
      click_button("Create")
      expect(page).to have_content("test")
    end

    it "updates the user table when a user joins an organization" do
      join_org
      expect(page).to have_content("hello123")
    end

    it "updates the user table when a user creates an organization" do
      click_link "New Organization"
      fill_in "Name", with: "test"
      fill_in "Password", with: "test"
      fill_in "Confirm Password", with: "test"
      fill_in "Email", with: "test@example.com"
      click_button("Create")
      expect(page).to have_content("test")
    end

    it "can not join an existing organization without the correct password" do
      Organization.create!(id: 100, name: "IIT", password: "test", email: "test@example.com")
      visit("/organizations")
      click_link "Join"
      fill_in "organization_password", with: "hello"
      click_button("Confirm")
      expect(page).to have_content("Wrong password")
    end

    it "can edit name of an existing organization if part of that organization" do
      join_org
      visit("/user")
      # Sanity check
      expect(page).to have_content("hello123")
      click_link("Edit Organization")
      fill_in "Name", with: "IIT"
      click_button("Update")
      expect(page).to have_content("IIT")
    end

    it "can not edit name of an existing organization if not part of that organization" do
      join_org
      Organization.create!(id: 100, name: "IIT", password: "test", email: "test@example.com")
      visit("/user")
      # Sanity check
      expect(page).to_not have_content("IIT")
      visit("/organizations/100/edit")
      expect(page).to have_content("That's not your organization")
    end

    it "can list all users for the current organization" do
      join_org
      User.create!(id: 100, name: "Max", uid: 100, provider: "google", organization_id: 99)
      User.create!(id: 101, name: "Joe", uid: 101, provider: "google", organization_id: 99)
      visit("/user")
      click_link("hello123")
      expect(page).to have_content("Joe")
      expect(page).to have_content("Max")
      expect(page).to have_content("mockuser")
    end

    it "can encrypt Organization password with bcrypt" do
      join_org
      org = Organization.find(99)
      org_pw = org.password_digest
      expect(org_pw).not_to eq("test")
    end

    it "can leave Organizations successfully" do
      join_org
      click_button("Leave Organization")
      # Add expectation below
    end

    it "creates a directory in /storage/ for the organization if the org doesn't already have one" do
      join_org
      # Sanity check
      FileUtils.remove_dir "#{Rails.root}/storage/hello123", true
      expect(File).not_to exist("#{Rails.root}/storage/hello123")
      Sushi.create!(
        name: "jstor",
        endpoint: "https://www.jstor.org/sushi",
        cust_id: "iit.edu",
        req_id: "galvinlib",
        report_start: "2016-01-01",
        report_end: "2016-12-31",
        password: "",
        organization_id: 99
      )
      visit("/sushi")
      first(:link, "Get CSV Report").click
      expect(File).to exist("#{Rails.root}/storage/hello123")
    end

    it "creates a directory in /storage/ for the organization on org creation" do
      # Sanity check
      FileUtils.remove_dir "#{Rails.root}/storage/test1", true
      expect(File).not_to exist("#{Rails.root}/storage/test1")
      visit("/organizations")
      click_link "New Organization"
      fill_in "Name", with: "test1"
      fill_in "Password", with: "test"
      fill_in "Confirm Password", with: "test"
      fill_in "Email", with: "test@example.com"
      click_button("Create")
      expect(File).to exist("#{Rails.root}/storage/test1")
    end
  end
end
