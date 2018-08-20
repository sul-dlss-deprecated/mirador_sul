# frozen_string_literal: true

FactoryBot.define do
  factory :annotation do
    user
    uuid { 'MyString' }
    canvas { 'http://www.example.com/hola' }
    data { '' }
  end
end
