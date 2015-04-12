FactoryGirl.define do
  factory :user do
    sequence email { |n| "email#{n}@example.com" }
    password 'password'
    password_confirmation { |u| u.password }
  end
end
