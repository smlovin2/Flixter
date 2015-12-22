FactoryGirl.define do
  factory :course do
    title "Awesomesauce 101"
    description "The best course ever!"
    cost 10.00
    association :user
  end
end
