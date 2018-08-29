require "rails_helper"

RSpec.describe SessionsController do
  let(:create_user_org_pair) do
    @user = create(:user, organization_id: 101)
    @organization = create(:organization, id: 101)
    session[:user_id] = @user.id
  end
  describe "Session Controller Tests" do
    # To get access to session variables with current_user and current_org
    include ControllerHelper
    it "Does something" do
     # Do something
    end
  end
end
