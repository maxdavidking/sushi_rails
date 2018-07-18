require "rails_helper"

RSpec.describe "Data Features" do
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
      organization_id: 99
    )
    visit("/sushi")
    click_link("Get CSV Report")
  end

  before(:each) do
    sign_in
    join_org
    mock_sushi
  end


  describe "Data Feature Tests", type: :feature do
    it "saves CSV to the data model through active storage" do
      visit("/user")
      expect(page).to have_content("jstor")
    end

    it "allows users to download reports to their browser from the org page" do
      visit("/user")
      click_link("Download")
      expect(response_headers["Content-Type"]).to eq "text/csv"
    end

    it "displays the download's timestamp on completion" do
      visit("/user")
      data = Datum.last
      timestamp = data.created_at.strftime("%Y-%m-%d %H:%M")
      expect(page).to have_content(timestamp)
    end
  end
end
