FactoryBot.define do
  factory :collection do
    sequence(:name) { |n| "My Collection #{n}" }
    user
  end
end
