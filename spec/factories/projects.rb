FactoryGirl.define do
  factory :project do
    association :customer
    association :user
    sequence(:name) { |n| "My Project #{n}"}
    date Date.today
    archived false
  end

end
