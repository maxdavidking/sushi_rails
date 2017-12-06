require 'rails_helper'

RSpec.describe "Sushi feature" do
  let(:view_sushi_connections) do
    visit('/')
    click_link('Sushi Connections')
  end
  describe "list all of the sushi connections for each user" do
    it "lists sushi connection information" do

      Sushi.create!(name: "jstor", endpoint: "https://www.jstor.org/sushi", cust_id: "iit.edu", req_id: "galvinlib", report_start: "2016-01-01", report_end: "2016-12-31", password: "")
      Sushi.create!(name: "acm", endpoint: "http://sushi4.scholarlyiq.com/SushiService.svc", cust_id: "X124552", req_id: "90633e00-fc53-4f70-9ae0-ac2c33d00014", report_start: "2016-01-01", report_end: "2016-12-31", password: "")

      view_sushi_connections

      expect(page).to have_content('jstor')
    end
  end
  describe "edit sushi connection information" do
    it "edits sushi connection information" do

      connection = Sushi.create!(name: "science direct", endpoint: "http://sushi4.scholarlyiq.com/SushiService.svc", cust_id: "X124552", req_id: "90633e00-fc53-4f70-9ae0-ac2c33d00014", report_start: "2016-01-01", report_end: "2016-12-31", password: "")

      view_sushi_connections
      first(:link, 'Edit Connection').click
      fill_in 'Name', with: connection.name
      click_on('Edit')

      expect(page).to have_content('science direct')
    end
  end
  #describe "delete sushi connection information" do
  #  it "deletes sushi connection information" do
#
#      Sushi.create!(name: "jstor", endpoint: "https://www.jstor.org/sushi", cust_id: "iit.edu", req_id: "galvinlib", report_start: "2016-01-01", report_end: "2016-12-31", password: "")
#      Sushi.create!(name: "acm", endpoint: "http://sushi4.scholarlyiq.com/SushiService.svc", cust_id: "X124552", req_id: "90633e00-fc53-4f70-9ae0-ac2c33d00014", report_start: "2016-01-01", report_end: "2016-12-31", password: "")
#
#      view_sushi_connections
#
#      expect(page).to have_content('jstor')
#    end
#  end
end
