FactoryGirl.define do
  factory :user do
  	first_name 'Birhanu'
  	last_name 'Hailemariam'
    sequence(:email) { |n| "#{first_name}.#{last_name}#{n}@example.com" }
  	password 'pw'
    confirmed_at Date.yesterday #1.day.ago

    factory :unconfirmed_user do
      confirmed_at nil
    end

  end

end
