FactoryGirl.define do
  factory :invoice do
    association :customer
    association :user

    date_of_an_invoice Date.tomorrow
    deadline Date.tomorrow
    payment_term "2"
    interest_in_arrears "9"
    sequence(:reference_number) { |n| "1234#{n}" }
  end

end
