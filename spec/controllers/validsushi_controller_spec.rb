require "rails_helper"

RSpec.describe ValidsushiController do
  # To get access to session variables with current_user and current_org
  include ControllerHelper
  describe "GET #new" do
    it "does not render the #new template" do
      validsushi = Validsushi.create!(
        name: "fake",
        endpoint: "https://www.jstor.org/sushi",
        cust_id: "YOUR_CUSTOMER_ID",
        req_id: "YOUR_REQUESTOR_ID",
        report_start: "2017-01-01",
        report_end: "2017-12-31",
        password: "OPTIONAL"
      )
      get :new, params: { id: validsushi.id }

      expect(response).not_to render_template(:new)
    end
  end
end
