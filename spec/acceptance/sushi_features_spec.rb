require "rails_helper"

RSpec.describe "Sushi Controller" do
  before(:each) do
    sign_in
    join_org
  end

  describe "Sushi CRUD for logged in user", type: :feature do
    it "lists all sushi connection information for logged in user" do
      create(:sushi, organization_id: 99)
      visit("/sushi")
      expect(page).to have_content("jstor")
    end

    it "requests sushi reports successfully" do
      # Sanity check
      visit("/user")
      expect(page).to_not have_content("jstor")
      create(:sushi, organization_id: 99)
      visit("/sushi")
      first(:link, "Get CSV Report").click
      visit("/user")
      expect(page).to have_content("jstor")
    end

    it "fails gracefully on unsuccessful sushi report request" do
      # Create connection with a bad url
      create(:sushi, organization_id: 99, endpoint: "www.badurl.com")
      visit("/sushi")
      first(:link, "Get CSV Report").click
      expect(page).to have_content("Failure")
    end

    it "can test the sushi connection successfully" do
      create(:sushi, organization_id: 99)
      visit("/sushi")
      first(:link, "Test Connection").click
      expect(page).to have_content("Success")
    end

    it "can test the sushi connection and provide failure message on fail" do
      create(:sushi, organization_id: 99, endpoint: "www.badurl.com")
      visit("/sushi")
      first(:link, "Test Connection").click
      expect(page).to have_content("Failure")
    end

    it "creates a new sushi connection" do
      # Sanity check
      visit("/sushi")
      expect(page).to_not have_content("test")
      visit("/sushi/new")
      fill_in "Name", with: "test1234"
      fill_in "Endpoint", with: "test"
      fill_in "Requestor ID", with: "test"
      fill_in "Customer ID", with: "test"
      fill_in "Report Start", with: "2017-01-01"
      fill_in "Report End", with: "2017-12-31"
      fill_in "Password", with: "test"
      click_button("Create")
      expect(page).to have_content("test")
    end

    it "edits sushi connection information", js: true do
      create(:sushi, organization_id: 99)
      visit("/sushi")
      first(:link, "Edit").click
      using_wait_time 10 do
        fill_in "Name", with: "test"
        click_on("Update")
      end
      expect(page).to have_content("test")
    end

    it "deletes sushi connection information" do
      create(:sushi, organization_id: 99)
      visit("/sushi")
      expect(page).to have_content("jstor")
      click_button("Delete")
      expect(page).to_not have_content("jstor")
    end

    it "only lists the sushi connections for a logged in user" do
      # Sanity check
      visit("/sushi")
      expect(page).to_not have_content("jstor")
      create(:sushi, organization_id: 99)
      create(:organization, id: 17)
      create(:sushi, organization_id: 17)
      visit("/sushi")
      expect(page).to have_content("jstor")
      expect(page).to_not have_content("acm")
    end

    it "updated sushi status without page refreshing", js: true do
      create(:sushi, organization_id: 99)
      visit("/sushi")

      # Sanity check
      expect(page).not_to have_content("successfully")

      # Submit form in new window
      new_window = open_new_window
      within_window new_window do
        visit ("/sushi")
        first(:link, "Get CSV Report").click
      end

      # Check for new value in previous window without page refreshing
      switch_to_window(windows.first)
      expect(page).to have_text("successfully")
    end
  end
end
