FactoryGirl.define do
  factory :ticket do
    drawing { create(:drawing) }
    entry { create(:entry, drawing: drawing) }

    trait :revealed do
      revealed_at { 1.day.ago }
    end
  end
end
