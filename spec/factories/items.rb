FactoryGirl.define do
  factory :item do
    name "MyString"
    date "2016-06-08"
    quantity 1
    unit "MyString"
    unit_price "9.99"
    vat 1
    invoice nil
  end
end
