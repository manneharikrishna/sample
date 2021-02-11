FactoryGirl.define do
  factory :payment do
    entry { create(:entry) }
    player { entry.player }
    amount { Faker::Number.between(-1.0, -100.0) }
  end
end
