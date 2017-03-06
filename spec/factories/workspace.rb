FactoryGirl.define do
  factory :workspace do
    sequence(:data) { |n| "{ \"some_json_data\": #{n} }" }
    collection
  end
end
