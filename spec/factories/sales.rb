FactoryGirl.define do
  factory :sale do
    association :user
    association :customer

    date Date.today
    status "PREPARING"
    description "Text"

    factory :sale_with_item do
      after(:create) do |sale|
        create(:item, sale: sale)
      end
    end
  end
end
