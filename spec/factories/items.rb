FactoryGirl.define do
  factory :item do
    association :invoice 

    name "MyString"
    date Date.tomorrow
    quantity 1
    unit "MyString"
    unit_price 9.99
    vat 1
    total 0
  end
end
