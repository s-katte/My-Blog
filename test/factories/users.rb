FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user-email-#{n}@blog.com" }
    sequence(:password) { |n| "Password-#{n}" }
  end
end
