require "rails_helper"

RSpec.describe DataController do
  let(:create_datum) do
    @file = create(:datum)
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
        # Need to find a way to purposefully get ActiveStorage to fail
        pending "Failure of ActiveStorage delete"
        expect(Datum.where(id: @file.id).count).to eq(1)
      end
      it "flashes a warning message" do
        create_datum
        # Need to find a way to purposefully get ActiveStorage to fail
        pending "Failure of ActiveStorage delete"
        expect(flash[:warning]).to eq("Something went wrong - #{@file} was not deleted.")
      end
    end
  end
end
