FactoryGirl.define do
  factory :pool_lottery_drawing, parent: :drawing do
    lottery do
      create(
        :lottery,
        :pool,
        tickets_count: tickets_count,
        ticket_price: ticket_price,
        payback_ratio: payback_ratio
      )
    end

    transient do
      ticket_price 10
      tickets_count 100
      payback_ratio 60
    end

    after(:create) do |drawing|
      create_list(:ticket, 10, drawing: drawing)
    end
  end
end
