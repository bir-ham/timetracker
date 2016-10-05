FactoryGirl.define do
  factory :task do

    name "Task"
    hours '3:21'
    payment_type "Per task"
    price "9.99"
    vat 9.99
    total 10
  end
end
