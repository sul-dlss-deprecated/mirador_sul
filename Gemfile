source 'https://rubygems.org'

gem 'rails', '~> 5.0.2'

gem 'bcrypt' # password digests

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Ruby general dependencies
gem 'okcomputer'
gem 'config'
gem 'faraday'

group :production do
  gem 'pg'
  gem 'honeybadger'
end

group :development do
  gem 'listen', '~> 3.0.5'
end

group :test, :development do
  # Use Puma as the app server
  gem 'puma', '~> 3.0'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  gem 'sqlite3'
  gem "factory_girl_rails", "~> 4.8" # for fixture data
  gem 'database_cleaner' # for cleaning out fixture data

  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'coveralls', require: false
  gem 'simplecov'
  gem 'rack-console'
  gem 'rubocop'
  gem 'rubocop-rspec'
end

group :deployment do
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'capistrano-shared_configs'
  gem 'dlss-capistrano'
end
