source 'https://rubygems.org'

gem 'rails', '3.2.2'
gem 'jquery-rails', '2.0.2'
gem 'mysql2', '0.3.11'
gem 'devise', '2.0.4'
gem 'cancan', '1.6.7'
gem 'simple_form', '2.0.1'
gem 'backbone-on-rails', '0.9.2.0'
gem 'smt_rails', '0.2.0'
gem 'i18n-js', :git => 'git://github.com/fnando/i18n-js.git'
gem 'rabl', '0.6.12'
gem 'validates_existence', '0.7.1'
gem 'foreigner', '1.1.6'
gem 'paperclip', '3.0.4'
gem 'multipart_body', '0.2.1'

group :assets do
  gem 'sass-rails', '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.4'
  gem 'twitter-bootstrap-rails', '2.0.8'
end

group :development do
  gem 'annotate', '2.4.0'
  gem 'quiet_assets', '1.0.0'
  gem 'thin', '1.3.1' #use thin instead of webrick for rails s
end

group :test do
  gem 'cucumber-rails', '1.3.0', require: false
  gem 'email_spec', '1.2.1'
  gem 'database_cleaner', '0.7.2'
  gem 'capybara', '1.1.2'
  gem 'capybara-webkit', '0.11.0'
  gem 'spork', '0.9.0'
  gem 'factory_girl_rails', '3.1.0', require: false
  gem 'launchy', '2.1.0'
  gem 'forgery', '0.5.0'
  gem 'rack-test', '0.6.1'
end

group :development, :test do
  gem 'debugger', '1.1.3'
  gem 'rspec-rails', '2.9.0'
  gem 'therubyracer', '0.10.1'
end

group :production do
  gem "pg"
end
