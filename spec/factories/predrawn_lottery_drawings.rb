FactoryGirl.define do
  factory :predrawn_lottery_drawing, parent: :drawing do
    lottery do
      create(
        :lottery,
        :predrawn,
        repeat_every: 2_592_000,
        tickets_count: tickets_count,
        ticket_price: ticket_price
      )
    end

    transient do
      tickets_count 10
      ticket_price 10
    end

    after(:create) do |drawing|
      create(:prize, prizeable: drawing, value: 100, quantity: 1)
    end
  end
end
