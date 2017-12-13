RSpec.describe "Helper Tests" do
  describe "Test helpers" do
    it "tests the current_user helper" do
      User.create!(id: 100, name: "Brian", organization: "test", uid: "0001111", provider: "google")
      expect(current_user.id).to eq(100)
    end
  end
end
