Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV["CPyEY8ChGVOGWfaBHyurHqdxG"], ENV["RkYXriKtunROoNLS7Dk2wQUo0iQIFvWnUrDNBjDq1qytqxjACO"]
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_SECRET"],
           scope: "profile", image_aspect_ratio: "square", image_size: 48, access_type: "online", name: "google"
end
