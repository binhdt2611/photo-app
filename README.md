# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

# Devise setup 
1. Add these gems to gem file
gem 'devise'
gem 'twitter-bootstrap-rails', '~> 5.0'
gem 'devise-bootstrap-views'
gem 'jquery-rails'

2. Run these commands
```
rails generate devise:install
rails generate devise User
```

3. Uncomment ## Confirmable and ## Trackable in db/migrate/migration_file.rb
```
## Trackable
t.integer  :sign_in_count, default: 0, null: false
t.datetime :current_sign_in_at
t.datetime :last_sign_in_at
t.string   :current_sign_in_ip
t.string   :last_sign_in_ip

# Confirmable
t.string   :confirmation_token
t.datetime :confirmed_at
t.datetime :confirmation_sent_at
t.string   :unconfirmed_email # Only if using reconfirmable
```

4. Add confirmable to user: https://github.com/heartcombo/devise/wiki/How-To:-Add-:confirmable-to-Users
add :confirmable, :trackable to devise section in app/models/user.rb
Run db:migrate
```
rake db:migrate
```

5. Setup Application controller load devise authentication

Add these lines to app/controllers/application_controller.rb
```
# Prevent CSRF attacks by raising an exception
# For APIs, you may want to use :null_session instead
protect_from_forgery with: :exception
before_action :authenticate_user!
```

Add this line to app/controllers/welcome_controller.rb to skip devise load when login page
skip_before_action :authenticate_user!, only: [:index]

6. Install twitter-bootstrap-rails
```
rails generate bootstrap:install static
rails g bootstrap:layout application
rails g devise:views:locale en
rails g devise:views:bootstrap_templates
```

> If we get an error "couldn't find file 'jquery' with type 'application/javascript'" after start app, check:
- gem 'jquery-rails' is installed?
- Add //= link application.js to app/assets/config/manifest.js
- Add this line to app/assets/stylesheets/application.css
*= require bootstrap_and_overrides 

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
