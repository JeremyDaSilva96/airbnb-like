require 'unsplash'

Unsplash.configure do |config|
  config.application_access_key = ENV['UNSPLASH_ACCESS_KEY']
  config.application_secret = ENV['UNSPLASH_SECRET_KEY']
  config.application_redirect_uri = "https://your-application-redirect-uri.com"
  config.utm_source = "airbnb_like_app"
end
