FactoryGirl.define do
  factory :project do
    association :user
    association :customer

    sequence(:name) { |n| "My Project #{n}"}
    deadline Date.today
    status 'NEW'
    description "Text"
    archived false

    factory :project_with_task do
      after(:create) do |project|
        create(:task, project: project)
      end
    end
  end

end
