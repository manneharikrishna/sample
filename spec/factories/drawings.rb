FactoryGirl.define do
  factory :drawing do
    lottery do
      create(
        :lottery,
        ticket_price: ticket_price,
        tickets_count: tickets_count,
        payback_ratio: payback_ratio
      )
    end

    starts_at { 1.hour.from_now }
    ends_at { 1.week.from_now }

    transient do
      ticket_price nil
      tickets_count nil
      payback_ratio nil
    end

    trait :with_tickets do
      after(:create) { |l| GenerateTickets.new(l).call }
    end

    DrawingStateMachine.states.each do |state|
      trait state.to_sym do
        after(:create) do |drawing|
          create(:drawing_transition, drawing: drawing, to_state: state)
        end
      end
    end
  end
end
