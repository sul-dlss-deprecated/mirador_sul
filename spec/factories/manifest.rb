FactoryBot.define do
  factory :manifest do
    sequence :url do |n|
      "http://example.com/iiif/#{n}/manifest.json"
    end
    user
  end
end
