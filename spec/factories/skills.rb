FactoryGirl.define do
  factory :skill do
    name "MyString"
    sequence(:name) {|n| "name#{n}" }
  end
end
