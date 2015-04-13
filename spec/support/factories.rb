FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password 'password'
    password_confirmation { |u| u.password }
  end

  factory :api_key do
    access_token SecureRandom.hex
    expired_at Time.zone.tomorrow
    user
  end

  factory :budget_sheet do
    name "February 2017"
    user
  end
end
