require 'rails_helper'

RSpec.describe "Sushi feature" do
  let(:create_user_sushi) do
    @user = User.create!(id: 100, name: "Brian", organization: "test", uid: "0001111", provider: "google")
    Sushi.create!(name: "jstor", endpoint: "https://www.jstor.org/sushi", cust_id: "iit.edu", req_id: "galvinlib", report_start: "2016-01-01", report_end: "2016-12-31", password: "", user_id: @user.id)
    Sushi.create!(name: "acm", endpoint: "http://sushi4.scholarlyiq.com/SushiService.svc", cust_id: "X124552", req_id: "90633e00-fc53-4f70-9ae0-ac2c33d00014", report_start: "2016-01-01", report_end: "2016-12-31", password: "", user_id: @user.id)
  end
  let(:view_sushi_connections) do
    visit('/')
    click_link('Sushi Connections')
  end
  describe "list all of the sushi connections for each user" do
    it "lists sushi connection information" do
      create_user_sushi
      view_sushi_connections

      expect(page).to have_content('jstor')
    end
  end

  describe "create new sushi connection" do
    it "creates a new sushi connection" do
      @user = User.create!(id: 100, name: "Brian", organization: "test", uid: "0001111", provider: "google")
      conn = Sushi.create!(name: "science direct", endpoint: "http://sushi4.scholarlyiq.com/SushiService.svc", cust_id: "X124552", req_id: "90633e00-fc53-4f70-9ae0-ac2c33d00014", report_start: "2016-01-01", report_end: "2016-12-31", password: "", user_id: @user.id)

      view_sushi_connections
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
  end

  describe "edit sushi connection information" do
    it "edits sushi connection information" do
      @user = User.create!(id: 100, name: "Brian", organization: "test", uid: "0001111", provider: "google")
      connection = Sushi.create!(name: "science direct", endpoint: "http://sushi4.scholarlyiq.com/SushiService.svc", cust_id: "X124552", req_id: "90633e00-fc53-4f70-9ae0-ac2c33d00014", report_start: "2016-01-01", report_end: "2016-12-31", password: "", user_id: @user.id)

      view_sushi_connections
      first(:link, 'Edit Connection').click
      fill_in 'Name', with: connection.name
      click_on('Edit')

      expect(page).to have_content('science direct')
    end
  end
  describe "delete sushi connection information" do
    it "deletes sushi connection information" do
      create_user_sushi

      view_sushi_connections
      expect(page).to have_content('jstor')
      first(:link, 'Delete').click

      expect(page).to_not have_content('jstor')
    end
  end
end
