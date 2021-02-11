FactoryGirl.define do
  factory :ticket_autoreveal do
    trait :weekly do
      ticket_type :weekly
    end

    trait :subscription do
      ticket_type :subscription
    end
  end
end
