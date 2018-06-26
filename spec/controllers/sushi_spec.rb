require "rails_helper"

RSpec.describe "Sushi Controller" do
  let(:sign_in) do
    visit "/"
    mock_auth_hash
    first(:link, "Login").click
    Organization.create!(id: 99,
      name: "hello123",
      password: "test",
      email: "test@example.com")
    current_user.update(organization_id: 99)
  end

  describe "Sushi CRUD for logged in user", type: :feature do
    include ApplicationHelper
    it "lists all sushi connection information for logged in user" do
      sign_in
      Sushi.create!(name: "jstor",
        endpoint: "https://www.jstor.org/sushi",
        cust_id: "iit.edu", req_id: "galvinlib",
        report_start: "2016-01-01",
        report_end: "2016-12-31",
        password: "",
        user_id: current_user.id,
        organization_id: current_organization.id)
      visit("/sushi")
      expect(page).to have_content("jstor")
    end

    it "requests sushi reports successfully" do
      sign_in
      Sushi.create!(name: "jstor",
        endpoint: "https://www.jstor.org/sushi",
        cust_id: "iit.edu",
        req_id: "galvinlib",
        report_start: "2016-01-01",
        report_end: "2016-12-31",
        password: "",
        user_id: current_user.id,
        organization_id: current_organization.id)
      visit("/sushi")
      first(:link, "Get CSV Report").click
      visit("/user")
      expect(page).to have_content("jstor")
    end

    it "fails gracefully on unsuccessful sushi report request" do
      sign_in
      Sushi.create!(
        name: "badurl",
        endpoint: "https://www.badurl.com",
        cust_id: "iit.edu",
        req_id: "galvinlib",
        report_start: "2016-01-01",
        report_end: "2016-12-31",
        password: "",
        user_id: current_user.id,
        organization_id: current_organization.id
      )
      visit("/sushi")
      first(:link, "Get CSV Report").click
      expect(page).to have_content("Failure")
      expect(page).to have_content("badurl")
    end

    it "can test the sushi connection successfully" do
      sign_in
      Sushi.create!(name: "jstor",
        endpoint: "https://www.jstor.org/sushi",
        cust_id: "iit.edu",
        req_id: "galvinlib",
        report_start: "2016-01-01",
        report_end: "2016-12-31",
        password: "",
        user_id: current_user.id,
        organization_id: current_organization.id)
      visit("/sushi")
      first(:link, "Test Connection").click
      expect(page).to have_content("Success")
    end

    it "can test the sushi connection and provide failure message on fail" do
      sign_in
      Sushi.create!(name: "jstor",
        endpoint: "https://www.badurl.com",
        cust_id: "iit.edu",
        req_id: "galvinlib",
        report_start: "2016-01-01",
        report_end: "2016-12-31",
        password: "",
        user_id: current_user.id,
        organization_id: current_organization.id)
      visit("/sushi")
      first(:link, "Test Connection").click
      expect(page).to have_content("badurl")
      expect(page).to have_content("Failure")
    end

    it "creates a new sushi connection" do
      sign_in
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

    it "automatically populates the user id field with the user's session ID" do
      sign_in
      visit("/sushi/new")
      page.has_selector?("input", text: current_user.id)
    end

    it "edits sushi connection information", js: true do
      sign_in
      Sushi.create!(name: "jstor",
        endpoint: "https://www.jstor.org/sushi",
        cust_id: "iit.edu",
        req_id: "galvinlib",
        report_start: "2016-01-01",
        report_end: "2016-12-31",
        password: "",
        user_id: current_user.id,
        organization_id: current_organization.id)
      visit("/sushi")
      first(:link, "Edit").click
      using_wait_time 10 do
        fill_in "Name", with: "test"
        click_on("Update")
      end
      expect(page).to have_content("test")
    end

    it "deletes sushi connection information" do
      sign_in
      Sushi.create!(name: "jstor",
        endpoint: "https://www.jstor.org/sushi",
        cust_id: "iit.edu",
        req_id: "galvinlib",
        report_start: "2016-01-01",
        report_end: "2016-12-31",
        password: "",
        user_id: current_user.id,
        organization_id: current_organization.id)
      visit("/sushi")
      expect(page).to have_content("jstor")
      click_button("Delete")
      expect(page).to_not have_content("jstor")
    end

    it "only lists the sushi connections for a logged in user" do
      sign_in
      User.create!(id: 100,
        name: "Max", organization_id: 99, uid: 1_000_000, provider: "google")
      Sushi.create!(name: "jstor",
        endpoint: "https://www.jstor.org/sushi",
        cust_id: "iit.edu",
        req_id: "galvinlib",
        report_start: "2016-01-01",
        report_end: "2016-12-31",
        password: "",
        user_id: current_user.id,
        organization_id: current_organization.id)
      Organization.create!(id: 17,
        name: "sample", password: "test", email: "test@example.com")
      Sushi.create!(name: "acm",
        endpoint: "https://www.jstor.org/sushi",
        cust_id: "iit.edu",
        req_id: "galvinlib",
        report_start: "2016-01-01",
        report_end: "2016-12-31",
        password: "",
        user_id: 100,
        organization_id: 17)
      visit("/sushi")
      expect(page).to have_content("jstor")
      expect(page).to_not have_content("acm")
    end

    it "updated sushi status without page refreshing", js: true do
      sign_in
      Sushi.create!(name: "jstor",
        endpoint: "https://www.jstor.org/sushi",
        cust_id: "iit.edu",
        req_id: "galvinlib",
        report_start: "2016-01-01",
        report_end: "2016-12-31",
        password: "",
        user_id: current_user.id,
        organization_id: current_organization.id)
      visit("/sushi")

      value = "successfully"
      expect(page).not_to have_content(value) # sanity check
      save_and_open_page

      # submit form in new window
      new_window = open_new_window
      within_window new_window do
        visit ("/sushi")
        first(:link, "Get CSV Report").click
      end

      # check for new value in previous window without page refreshing
      switch_to_window(windows.first)
      expect(page).to have_text(value)
    end
  end
end
