FactoryGirl.define do
  factory :license do
    name { Faker::Lorem.sentence }
    lottery_type { Lottery::TYPES.sample }

    min_duration 1
    max_duration 30
    max_tickets_count 1000
    max_total_revenue 100_000
    min_payback_ratio 10
    max_payback_ratio 90
  end
end
