RSpec.describe "Helper Tests" do
  describe "Test current_user helper" do
    it "tests the helper" do
      User.create!(id: 100, name: "Brian", organization: "test", uid: "0001111", provider: "google")
      expect(current_user.id).to eq(100)
    end
  end
end
