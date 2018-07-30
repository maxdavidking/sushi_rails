require "rails_helper"

RSpec.describe DataController do
  let(:create_datum) do
    Organization.create!(id: 100, name: "IIT", password: "test", email: "test@example.com")
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
    @file = Datum.create!(id: 101, date: "2017-01-01", organization_id: 100, sushi_id: 201)
  end
  # To get access to session variables with current_user and current_org
  include ControllerHelper
  describe "DELETE #destroy" do
    # If the file deletes successfully
    context "when a file is deleted" do
      it "no longer exists" do
        create_datum
        delete :destroy, params: { id: @file.id }
        expect(Datum.where(id: @file.id).count).to eq(0)
      end
      it "flashes a success message" do
        create_datum
        delete :destroy, params: { id: @file.id }
        expect(flash[:success]).to eq("File was successfully deleted.")
      end
    end
    # If the file fails to delete in ActiveStorage
    context "when a file fails to delete" do
      it "does not delete the file" do
        create_datum
        pending "Failure of ActiveStorage file needs to be recreated"
        expect(Datum.where(id: @file.id).count).to eq(1)
      end
      it "flashes a warning message" do
        create_datum
        pending "Failure of ActiveStorage file needs to be recreated"
        expect(flash[:warning]).to eq("Something went wrong - #{@file} was not deleted.")
      end
    end
  end
end
