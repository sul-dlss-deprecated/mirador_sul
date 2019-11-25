# frozen_string_literal: true

FactoryBot.define do
  sequence(:name) { |n| "John Doe #{n}" }

  factory :user, aliases: [:user_local] do
    name
    sequence(:email) { |n| "jdoe#{n}@example.com" }
    source { 'local' }
    password { 'password' }
    after(:build) do |user|
      class << user
        def create_sample_data
          true
        end
      end
    end
  end

  factory :user_stanford, class: 'User' do
    name
    sequence(:email) { |n| "jdoe#{n}@stanford.edu" }
    source { 'sunetid' }
    password { 'password' }
    after(:build) do |user|
      class << user
        def create_sample_data
          true
        end
      end
    end
  end

  factory :user_sample_data, class: 'User' do
    name
    sequence(:email) { |n| "jdoe#{n}@example.com" }
    source { 'sample' }
    password { 'password' }
  end
end
