FactoryGirl.define do
  factory :item do

    name "Item"
    quantity 1
    unit "Piece"
    unit_price 9.99
    vat 1
    total 10
  end
end
