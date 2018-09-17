# frozen_string_literal: true

FactoryBot.define do
  factory :workspace do
    sequence(:name) { |n| "Workspace #{n}" }
    sequence(:data) { |n| "{ \"some_json_data\": #{n} }" }
    collection
  end
end
