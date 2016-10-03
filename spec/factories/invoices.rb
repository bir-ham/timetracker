FactoryGirl.define do
  factory :invoice do
    association :user

    date_of_an_invoice Date.tomorrow
    deadline Date.tomorrow
    payment_term 2
    interest_in_arrears 9
    sequence(:reference_number) { |n| "1234#{n}" }
    description 'Lorem lipsum'

    factory :invoice_with_sale do
      association :sale, strategy: :build
    end

    factory :invoice_with_project do
      association :project, strategy: :build
    end

  end

end
