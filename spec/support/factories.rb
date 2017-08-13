FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password 'password'
    password_confirmation { |u| u.password }
  end

  factory :api_key do
    secret BCrypt::Password.create(SecureRandom.hex)
    expired_at Time.zone.tomorrow
    user
  end

  factory :budget_sheet do
    name "February 2017"
    user
  end

  factory :category do
    name "Coffee House"
    budget_amount 2500
    budget_sheet
  end

  factory :entry do
    description "Local Coffee"
    occurred_on Time.zone.yesterday
    amount 540
    category
    budget_sheet
  end
end
