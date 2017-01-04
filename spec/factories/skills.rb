FactoryGirl.define do
  factory :skill do
    sequence(:name) {|n| "name#{n}" }
  end
end
