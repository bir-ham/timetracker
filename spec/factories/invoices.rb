FactoryGirl.define do
  factory :invoice do
    customer "ABC"
    #date "2016-02-20 18:53:05"
    date_of_an_invoice "2016-02-20"
    deadline "2016-02-20"
    payment_term "2"
    interest_on_arrears "9"
    reference_number "1234"
  end

end
