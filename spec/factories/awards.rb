FactoryGirl.define do
  factory :award do
    player { create(:player) }
    entry { create(:entry, player: player) }

    amount { Faker::Commerce.price(10..100) }
    status 'completed'
  end
end
