FactoryGirl.define do
  factory :item do
    association :sale

    name "Item"
    date Date.tomorrow
    quantity 1
    unit "Piece"
    unit_price 9.99
    vat 1
    total 10
  end
end
