FactoryGirl.define do
  factory :task do
    association :project

    name "Task"
    date Date.today
    price_type "Per task"
    price "9.99"
    vat 9.99
    total 10
  end
end
