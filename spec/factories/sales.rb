FactoryGirl.define do
  factory :sale do
    customer_id 1
    user_id 1
    date "2016-09-28"
    status "MyString"
    description "MyText"
  end
end
