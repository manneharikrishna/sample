FactoryGirl.define do
  factory :predrawn_lottery, parent: :lottery do
    tickets_count 10
    ticket_price 10

    after(:create) do |lottery|
      create(:prize, prizeable: lottery, value: 100, quantity: 1)
    end
  end
end
