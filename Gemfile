source 'https://rubygems.org'

gem 'rails', '~> 5.2.0'

gem 'bcrypt' # password digests

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Ruby general dependencies
gem 'okcomputer'
gem 'config'
gem 'faraday'
gem 'high_voltage', '~> 3.0.0'
gem 'devise'
gem 'bootstrap', '4.0.0.alpha6'
gem 'jquery-rails'
gem 'cancancan'
gem 'mirador_rails'
gem 'sul_styles'

# for asset pipeline
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end

group :production do
  gem 'pg'
  gem 'honeybadger'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test, :development do
  # Use Puma as the app server
  gem 'puma', '~> 3.0'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'sqlite3'
  gem "factory_bot_rails", "~> 4.8" # for fixture data
  gem 'database_cleaner' # for cleaning out fixture data

  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'simplecov'
  gem 'rack-console'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'capybara'
end

group :deployment do
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-shared_configs'
  gem 'dlss-capistrano'
end
