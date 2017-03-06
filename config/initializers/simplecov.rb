# The code coverage is mis-reported unless we startup SimpleCov in an initializer
if Rails.env.test?
  require 'simplecov'
  SimpleCov.start 'rails'
end
