require 'rails_helper'

RSpec.describe "Data Controller" do
  let (:sign_in) do
    visit '/'
    mock_auth_hash
    click_link "Login"
    Organization.create!(id: 99, name: "hello123", password: "test", email: "test@example.com")
    current_user.update(organization_id: 99)
  end

  let (:mock_sushi) do
    Sushi.create!(id: 201, name: "jstor", endpoint: "https://www.jstor.org/sushi", cust_id: "iit.edu", req_id: "galvinlib", report_start: "2016-01-01", report_end: "2016-12-31", password: "", organization_id: current_organization.id)
    Datum.create!(date: "2014-01-01", file: "/hello123/jstor-2018-04-04.csv", organization_id: 99, sushi_id: 201)
  end
  let (:join_org) do
    visit("/organizations")
    click_link "Join"
    fill_in "organization_password", with: "test"
    click_button("Confirm")
  end

  describe "Data Features", :type => :feature do
    include ApplicationHelper
    it "lists all downloaded COUNTER reports for the organization" do
      sign_in
      mock_sushi
      join_org
      click_link("hello123")
      expect(page).to have_content("jstor-2018-04-04.csv")
    end

    it "saves CSV to the data model" do
      sign_in
      Sushi.create!(id: 201, name: "jstor", endpoint: "https://www.jstor.org/sushi", cust_id: "iit.edu", req_id: "galvinlib", report_start: "2016-01-01", report_end: "2016-12-31", password: "", organization_id: current_organization.id)
      join_org
      visit("/sushi")
      click_link("Get CSV Counter Report")
      visit("/organizations/99")
      expect(page).to have_content("jstor")
    end

    it "allows users to download reports to their browser from the org page" do
      sign_in
      mock_sushi
      join_org
      click_link("hello123")
      click_link("/hello123/jstor-2018-04-04.csv")
      expect(response_headers['Content-Type']).to eq "text/csv"
    end
  end
end
