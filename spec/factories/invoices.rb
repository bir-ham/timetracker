FactoryGirl.define do
  factory :invoice do
    association :customer, strategy: :build
    association :user, strategy: :build

    date_of_an_invoice Date.tomorrow
    deadline Date.tomorrow
    payment_term "2"
    interest_in_arrears "9"
    reference_number "1234"
  end

end
