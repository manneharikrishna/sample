FactoryGirl.define do
  factory :pool_lottery, parent: :lottery do
    tickets_count 100
    ticket_price 10
    payback_ratio 60

    after(:create) do |lottery|
      create(:prize, prizeable: lottery, value: 100, quantity: 1)
    end
  end
end
