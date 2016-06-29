FactoryGirl.define do
  factory :invoice do
    association :customer
    association :user

    factory :invoice_with_item do
      after(:create) do |invoice|
        create(:item, invoice: invoice)
      end  
    end

    date_of_an_invoice Date.tomorrow
    deadline Date.tomorrow
    payment_term ""
    interest_in_arrears "9"
    sequence(:reference_number) { |n| "1234#{n}" }
  end

end
