FactoryGirl.define do
  factory :prize do
    prizeable { create(:drawing) }

    sequence(:name) { |n| "Prize #{n}" }

    value { Faker::Commerce.price(1..100.0) }
    quantity { Faker::Number.between(1, 10) }

    image { fixture_file_upload('image.jpg', 'image/jpeg') }

    trait :weekly do
      reveal_type :drawing_end
    end

    trait :subscription do
      reveal_type :subscription
    end
  end
end
