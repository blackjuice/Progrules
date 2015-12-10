source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.18'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
gem 'bootstrap-sass', '3.2.0.0'

########
## group :assets do
##   gem 'sass-rails',   '~> 3.2.3'
##   gem 'coffee-rails', '~> 3.2.1'
##   gem 'sqlite3'
##   # See https://github.com/sstephenson/execjs#readme for more supported runtimes
##   gem 'therubyracer', :platforms => :ruby
##   gem 'rspec-rails'
##   gem 'uglifier', '>= 1.0.3'
## end
#########



group :development, :test do
  gem 'sqlite3'
  gem 'debugger'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'factory_girl_rails', '~> 4.5.0'
end

group :test do
  gem "shoulda-matchers", "~> 2.8.0"
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  
end
group :production do
#  gem 'pg'
end

group :assets do
  gem 'therubyracer', :platforms => :ruby
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'haml'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

