source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails',                           '~> 4.2.2'

# Use mysql as the database for Active Record
gem 'mysql2',                          '~> 0.4.2'

#HTTP server for Rack applications
gem 'unicorn',                         '~> 5.0'

gem 'uglifier',                        '>= 1.3.0'
gem 'turbolinks',                      '~> 2.5.3'

gem 'jquery-ui-rails'

# ------- Rails Assets Group -------
source 'https://rails-assets.org' do
  gem 'rails-assets-jquery'
  gem 'rails-assets-jquery-ujs'
  gem 'rails-assets-select2', '~> 3.5.2'
end
gem 'modernizr-rails'
# Use SCSS for stylesheets
gem 'sass-rails'
gem 'bootstrap-sass'

#Material design for bootstrap
gem 'bootstrap-material-design', '~> 0.1.7'


## Js
gem 'js-initializers',                 '~> 0.0.1'

# Select2 Wrapper
gem 'select2_simple_form', github: 'lndl/select2_simple_form', tag: '0.5'

# Applications settings
gem 'rails_config',                    '~> 0.4.2'

# Notifications
gem 'exception_notification',          '~> 4.0.1'

# Responders (for DRY flash behaviour)
gem 'responders',                      '~> 2.1.0'

# Forms
gem 'simple_form',                     '~> 3.1.0'
gem 'nested_form',                     '~> 0.3.2'

# Environment variables
gem 'dotenv-rails',                    '~> 0.11.1'

#Elasticsearch
gem 'elasticsearch-model',
  git: 'git://github.com/elasticsearch/elasticsearch-rails.git'
gem 'elasticsearch-rails',
  git: 'git://github.com/elasticsearch/elasticsearch-rails.git'

#Process manager for applications with multiple components
gem 'foreman',                         '~> 0.78.0'

#to create a new serializer
gem 'active_model_serializers',        '>= 0.10.0.rc4', '< 1.0'

group :development do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug',                        '~> 4.0.5'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console',                   '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring',                        '~> 1.3.4'
  gem 'better_errors',                 '~> 2.1.1'
  # Deployment
  gem 'capistrano',                    '~> 3.4.0'
  gem 'capistrano-rbenv',              '~> 2.0.3', require: false
  gem 'capistrano-rails',              '~> 1.1.2', require: false
  gem 'capistrano-foreman',            '~> 1.2.0', require: false
  gem 'airbrussh',          '~> 0.3',   require: false
  # Entity-Relationship Diagram
  gem 'rails-erd',                     '~> 1.4.0'
  #IRB developer console
  gem 'pry'
end


group :development, :test do
  # Factories
  gem 'factory_girl_rails',            '~> 4.5.0'
  # Genarate Fake data
  gem 'faker',                         '~> 1.4.3'
  # Test gem
  gem 'rspec-rails',                   '~> 3.1.0'
end

group :test do
  # Test tools
  gem 'shoulda-matchers',              github: 'thoughtbot/shoulda-matchers', require: false
  # Test coverage
  gem 'simplecov',                     '~> 0.9.1', require: false
  gem 'simplecov-console',             '~> 0.1.3', require: false
  gem 'simplecov-rcov',                '~> 0.2.3', require: false
  # Test result format
  gem 'nyan-cat-formatter'
  # Database test
  gem 'database_cleaner'
end
