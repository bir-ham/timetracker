FactoryGirl.define do
  factory :invoice do
    association :customer
    association :user

    factory :invoice_with_item do
      payment_term ""
      after(:create) do |invoice|
        create(:item, invoice: invoice)
      end  
    end

    date_of_an_invoice Date.tomorrow
    deadline Date.tomorrow
    payment_term 2
    interest_in_arrears 9
    sequence(:reference_number) { |n| "1234#{n}" }
    description 'Lorem lipsum'
  end

end
