require "rails_helper"

RSpec.describe ValidsushiController do
  # To get access to session variables with current_user and current_org
  include ControllerHelper
  describe "GET #new" do
    it "does not render the #new template" do
      get :new

      expect(response).not_to render_template(:new)
    end
  end
end
