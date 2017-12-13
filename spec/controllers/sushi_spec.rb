require 'rails_helper'

RSpec.describe 'Sushi Controller' do
  let (:sign_in) do
    visit '/'
    mock_auth_hash
    click_link "Google"
  end

  describe "Sushi CRUD for logged in user", :type => :feature do
    include ApplicationHelper
    it "lists all sushi connection information for logged in user" do
      sign_in
      Sushi.create!(name: "jstor", endpoint: "https://www.jstor.org/sushi", cust_id: "iit.edu", req_id: "galvinlib", report_start: "2016-01-01", report_end: "2016-12-31", password: "", user_id: current_user.id)
      visit('/sushi')

      expect(page).to have_content('jstor')
    end

    it "creates a new sushi connection" do
      sign_in
      conn = Sushi.create!(name: "science direct", endpoint: "http://sushi4.scholarlyiq.com/SushiService.svc", cust_id: "X124552", req_id: "90633e00-fc53-4f70-9ae0-ac2c33d00014", report_start: "2016-01-01", report_end: "2016-12-31", password: "", user_id: current_user.id)

      visit('/sushi')
      click_link("Create Sushi Connection")
      fill_in "Name", with: conn.name
      fill_in "Endpoint", with: conn.endpoint
      fill_in "Requestor ID", with: conn.req_id
      fill_in "Customer ID", with: conn.cust_id
      fill_in "Report Start", with: conn.report_start
      fill_in "Report End", with: conn.report_end
      fill_in "Password", with: conn.password
      visit('/sushi')

      expect(page).to have_content('science direct')
    end

    it "edits sushi connection information" do
      sign_in
      Sushi.create!(name: "jstor", endpoint: "https://www.jstor.org/sushi", cust_id: "iit.edu", req_id: "galvinlib", report_start: "2016-01-01", report_end: "2016-12-31", password: "", user_id: current_user.id)
      conn = Sushi.create!(name: "science direct", endpoint: "http://sushi4.scholarlyiq.com/SushiService.svc", cust_id: "X124552", req_id: "90633e00-fc53-4f70-9ae0-ac2c33d00014", report_start: "2016-01-01", report_end: "2016-12-31", password: "", user_id: current_user.id)
      visit('/sushi')
      first(:link, 'Edit Connection').click
      fill_in 'Name', with: conn.name
      click_on('Edit')

      expect(page).to have_content('science direct')
    end

    it "deletes sushi connection information" do
      sign_in
      Sushi.create!(name: "jstor", endpoint: "https://www.jstor.org/sushi", cust_id: "iit.edu", req_id: "galvinlib", report_start: "2016-01-01", report_end: "2016-12-31", password: "", user_id: current_user.id)
      visit('/sushi')
      expect(page).to have_content('jstor')
      first(:link, 'Delete').click

      expect(page).to_not have_content('jstor')
    end

    it "only lists a subset of connections" do
      sign_in
      User.create!(id: 100, name: "Max", organization: "IIT", uid: 1000000, provider: 'google')
      Sushi.create!(name: "jstor", endpoint: "https://www.jstor.org/sushi", cust_id: "iit.edu", req_id: "galvinlib", report_start: "2016-01-01", report_end: "2016-12-31", password: "", user_id: current_user.id)
      Sushi.create!(name: "acm", endpoint: "https://www.jstor.org/sushi", cust_id: "iit.edu", req_id: "galvinlib", report_start: "2016-01-01", report_end: "2016-12-31", password: "", user_id: 100)
      visit('/sushi')
      expect(page).to have_content('jstor')
      expect(page).to_not have_content('acm')
    end
  end
end
