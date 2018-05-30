require "rails_helper"

RSpec.describe "ValidsushiController" do
  let(:sign_in) do
    visit "/"
    mock_auth_hash
    first(:link, "Login").click
    Validsushi.create!(
      name: "jstor",
      endpoint: "https://www.jstor.org/sushi",
      cust_id: "YOUR_CUSTOMER_ID",
      req_id: "YOUR_REQUESTOR_ID",
      report_start: "2017-01-01",
      report_end: "2017-12-31",
      password: "OPTIONAL"
    )
    Organization.create!(id: 99, name: "hello123", password: "test", email: "test@example.com")
    current_user.update(organization_id: 99)
    visit("/sushi/new")
    click_button("Import Connection")
  end

  describe "Valid Sushi features", type: :feature do
    include ApplicationHelper
    it "Lists all valid Sushi connections" do
      sign_in
      expect(page).to have_content("jstor")
    end
    it "Auto populates sushi form with valid sushi connection info" do
      sign_in
      click_link("Import")
      expect(page).to have_selector("input[value='jstor']")
    end
  end
end
