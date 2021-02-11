FactoryGirl.define do
  factory :deposit do
    player { create(:player) }

    amount { Faker::Commerce.price(10..100) }
    nets_payment_id '56199fc1-4d9b-4599-d1dc-08d5dd838a93'
    status 'completed'
  end
end
