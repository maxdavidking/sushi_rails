module ApplicationHelper
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:google] = {
      "provider"    => "google",
      "uid"         => "123545",
      "info"        => {
        "name"     => "mockuser",
        "location" => "test_loc",
        "urls"     => "https://www.test.com",
        "image"    => "https://www.test.com/image.png"
      },
      "credentials" => {
        "token"  => "mock_token",
        "secret" => "mock_secret"
      }
    }
  end

  def sign_in
    visit "/"
    mock_auth_hash
    first(:link, "Login").click
  end

  def join_org
    create(:organization, id: 99)
    visit("/organizations")
    click_link "Join"
    fill_in "organization_password", with: "test"
    click_button("Confirm")
  end
end
