# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Whitelist::Application.initialize!
Whitelist::Application.config.secret_token = ENV.fetch("SECRET_TOKEN")

