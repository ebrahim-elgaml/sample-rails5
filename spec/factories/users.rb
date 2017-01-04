FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@test.com" }
    sequence(:first_name) {|n| "first_name#{n}" }
    sequence(:last_name) {|n| "last_name#{n}" }
    password "123456789"
  end
end
