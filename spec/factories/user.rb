FactoryGirl.define do
  sequence(:name) { |n| "John Doe #{n}" }

  factory :user, aliases: [:user_local] do
    name
    sequence(:email) { |n| "jdoe#{n}@example.com" }
    source 'local'
    password_digest 'abc'
  end

  factory :user_stanford, class: User do
    name
    sequence(:email) { |n| "jdoe#{n}@stanford.edu" }
    source 'sunetid'
    password_digest 'abc'
  end
end