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

# Setup Stripe Payment
1. Sign-up Stripe account at stripe.com
2. Copy publishable and secret api_key
3. Add gem stripe to Gemfile
```
gem 'stripe'
```

Runs bundle to install
```
bundle install --without production
```
4. Create config/initializers/stripe.rb to store Stripe API_KEYs, paste this content to the file
```
Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_TEST_PUBLISHABLE_KEY'],
  :secret_key => ENV['STRIPE_TEST_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
```


# Payment Models
1. Create Payment model and run db:migrate
```
rails generate model Payment email:string token:string user_id:integer
rake db:migrate
```

# Image Upload
1. Add new gems
```
# Use for upload image
gem 'carrierwave'
gem 'mini_magick'
gem 'fog-core', '2.1.0'
```
2. Create Image Model
```
rails generate scaffold Image name:string picture:string user:references
rake db:migrate
rails g bootstrap:themed Images

# Add has_many :images to app/models/user.rb
```
3. Create uploader Picture
```
rails generate uploader Picture

# Add to app/model/image.rb
mount_uploader :picture, PictureUploader

```
4. Pull up the _form.html.erb partial under app/views/images folder and update it

```
<%= form_for @image, :html => { multipart: true, :class => "form-horizontal image" } do |f| %>
```

```<div class="controls">

<%= f.file_field :picture, accept: 'image/jpeg,image/gif,image/png' %>

</div>```


5. Update your create action in the images_controller.rb file under app/controllers folder by adding the line below under @image = Image.new...:
@image.user = current_user

6. Modify app/views/images/show.html.erb
* ...
