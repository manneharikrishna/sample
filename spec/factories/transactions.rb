FactoryGirl.define do
  factory :transaction do
    player { create(:player) }
    amount { Faker::Commerce.price(-100..-10) }
  end
end
