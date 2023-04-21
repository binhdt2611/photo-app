# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# We don't have our smtp server, so should update these when we have
ActionMailer::Base.smtp_settings = {
  :address => 'smtp.server.com', 
  :port => '587',
  :authentication => :plain,
  :user_name => ENV['EMAIL_USER_NAME'],
  :password => ENV['EMAIL_PASSWD'],
  :domain => 'heroku.com',
  :enable_starttls_auto => true
}
