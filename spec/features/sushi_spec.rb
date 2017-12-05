require 'rails_helper'

RSpec.describe "Sushi feature" do
  describe "list all of the sushi connections for each user" do
    it "lists sushi connection information" do
      #1. create your test data
      Sushi.create!(name: "jstor", endpoint: "https://www.jstor.org/sushi", cust_id: "iit.edu", req_id: "galvinlib", report_start: "2016-01-01", report_end: "2016-12-31", password: "")
      #2. interact with the app
      visit('/')
      click_link('Sushi Connections')
      #3. expect something to happen
      expect(page).to have_content('jstor')
    end
  end
end
