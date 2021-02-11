FactoryGirl.define do
  factory :withdrawal do
    player { create(:player) }
    amount { Faker::Commerce.price(-100..-10) }
  end
end
