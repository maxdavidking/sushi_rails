require "rails_helper"

RSpec.describe "Data Controller" do
  let(:sign_in) do
    visit "/"
    mock_auth_hash
    first(:link, "Login").click
    Organization.create!(id: 99, name: "hello123", password: "test", email: "test@example.com")
    current_user.update(organization_id: 99)
  end

  let(:join_org) do
    visit("/organizations")
    click_link "Join"
    fill_in "organization_password", with: "test"
    click_button("Confirm")
  end

  let(:mock_sushi) do
    Sushi.create!(
      id: 201,
      name: "jstor",
      endpoint: "https://www.jstor.org/sushi",
      cust_id: "iit.edu",
      req_id: "galvinlib",
      report_start: "2016-01-01",
      report_end: "2016-12-31",
      password: "",
      organization_id: current_organization.id
    )
    visit("/sushi")
    click_link("Get CSV Report")
  end

  describe "Data Features", type: :feature do
    include ApplicationHelper
    it "saves CSV to the data model through active storage" do
      sign_in
      join_org
      mock_sushi
      visit("/user")
      expect(page).to have_content("jstor")
    end

    it "allows users to download reports to their browser from the org page" do
      sign_in
      join_org
      mock_sushi
      visit("/user")
      click_link("Download")
      expect(response_headers["Content-Type"]).to eq "text/csv"
    end

    it "displays the download's timestamp on completion" do
      sign_in
      join_org
      mock_sushi
      visit("/user")
      data = Datum.last
      timestamp = data.created_at.strftime("%Y-%m-%d %H:%M")
      expect(page).to have_content(timestamp)
    end
  end
end
