require "rails_helper"

RSpec.describe "ValidsushiController" do
  let(:import_sushi) do
    Validsushi.create!(
      name: "jstor",
      endpoint: "https://www.jstor.org/sushi",
      cust_id: "YOUR_CUSTOMER_ID",
      req_id: "YOUR_REQUESTOR_ID",
      report_start: "2017-01-01",
      report_end: "2017-12-31",
      password: "OPTIONAL"
    )
    visit("/sushi/new")
    click_button("Import Connection")
  end

  before(:each) do
    sign_in
    join_org
    import_sushi
  end

  describe "Valid Sushi features", type: :feature do
    it "Lists all valid Sushi connections" do
      expect(page).to have_content("jstor")
    end
    it "Auto populates sushi form with valid sushi connection info" do
      click_link("Import")
      expect(page).to have_selector("input[value='jstor']")
    end
  end
end
