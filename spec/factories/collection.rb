# frozen_string_literal: true

FactoryBot.define do
  factory :collection do
    sequence(:name) { |n| "My Collection #{n}" }
    user
  end
end
