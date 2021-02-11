FactoryGirl.define do
  factory :entry do
    drawing { create(:drawing) }
    player { create(:player) }
    photo { create(:photo, player: player) }

    tickets_count { Faker::Number.between(1, 5) }

    trait :revealed do
      revealed_at { 1.day.ago }
    end
  end
end
