FactoryGirl.define do
  factory :customer do
    sequence(:name) { |n| "name#{n}" }
    sequence(:phone_number) { |n| "12345678910#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    address "Kifle ketam: Bole, Kebele: 21, House number: 324"
  end
end
