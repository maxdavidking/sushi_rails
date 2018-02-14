require 'rails_helper'

RSpec.describe "ValidsushiController" do
  let (:sign_in) do
    visit '/'
    mock_auth_hash
    click_link "Google"
  end
  describe "Valid Sushi features", :type => :feature do
    include ApplicationHelper
    it "Lists all valid Sushi connections" do
      sign_in
      Validsushi.create!(name: "jstor", endpoint: "https://www.jstor.org/sushi", cust_id: "YOUR_CUSTOMER_ID", req_id: "YOUR_REQUESTOR_ID", report_start: "2017-01-01", report_end: "2017-12-31", password: "OPTIONAL")
      click_link("Valid COUNTER Connections")
      save_and_open_page
      expect(page).to have_content("jstor")
    end
    it "Imports valid sushi connections to user" do
      sign_in
    end
  end
end
