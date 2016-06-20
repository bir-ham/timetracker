FactoryGirl.define do
  factory :user do
  	first_name 'Birhanu'
  	second_name 'Hailemariam'
    sequence(:email) { |n| "birhanu#{n}@example.com" }
  	password 'pw'
    confirmed_at 7.days.ago
  end
  
end
