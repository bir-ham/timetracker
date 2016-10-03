FactoryGirl.define do
  factory :sale do
    association :invoice
    association :customer
    association :user
    association :items

    date Date.today
    status "PENDING"
    description "Text"

    factory :sale_with_customer_and_user do
      association :customer, strategy: :build
      association :user, strategy: :build
    end

    factory :sale_with_item do
      after(:create) do |sale|
        create(:item, sale: sale)
      end
    end
  end
end
