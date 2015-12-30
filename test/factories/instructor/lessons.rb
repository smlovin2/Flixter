FactoryGirl.define do
  factory :lesson do
    title "The Lesson"
    subtitle "A lesson about lessons"
    association :section
  end

end
