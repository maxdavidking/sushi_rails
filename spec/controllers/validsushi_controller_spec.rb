require "rails_helper"

RSpec.describe ValidsushiController do
  # To get access to session variables with current_user and current_org
  include ControllerHelper
  describe "GET #new" do
    it "renders the #new template" do
      validsushi = create(:validsushi)
      get :new, params: { id: validsushi.id }

      expect(response).to render_template(:new)
    end
  end
end
