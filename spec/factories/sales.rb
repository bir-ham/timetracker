FactoryGirl.define do
  factory :sale do
    #association :invoice
    association :customer
    association :user
    #association :item

    date Date.today
    status "PENDING"
    description "Text"

    factory :sale_with_item do
      after(:create) do |sale|
        create(:item, sale: sale)
      end
    end
  end
end
