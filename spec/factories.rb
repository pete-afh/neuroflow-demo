FactoryBot.define do
  factory :user do
    name { "John Doe" }
    sequence(:email) { |n| "john#{n}@doe.com" }
    current_streak { 0 }
    longest_streak { 1 }
    password { "password" }
  end

  factory :mood do
    name { "happy" }
    association :user
  end
end
