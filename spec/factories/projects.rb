FactoryGirl.define do
  factory :project do
    #association :invoice
    association :customer
    association :user
    #association :item

    sequence(:name) { |n| "My Project #{n}"}
    deadline Date.today
    archived false

    factory :project_with_task do
      after(:create) do |project|
        create(:task, project: project)
      end
    end
  end

end
