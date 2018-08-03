require "rails_helper"

RSpec.describe "ValidsushiController" do
  let(:import_sushi) do
    create(:validsushi)
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
