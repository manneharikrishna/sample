FactoryGirl.define do
  factory :subscription do
    player { create(:player) }
    tickets_count { Faker::Number.between(1, 10) }
    photo { create(:photo, player: player) }

    trait :active do
      status 'active'
      data { { nets_token: 'XvmOaZdTrK7XL2ILTpICz8wM/pM=' } }
      payment_method 'Visa'
      card_expiration_date 1.year.from_now
      card_last_digits '1234'
      expires_on 1.year.from_now.to_date
    end

    trait :inactive do
      status 'inactive'
    end

    trait :expired do
      expires_on 1.day.ago
    end
  end
end
