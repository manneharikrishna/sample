shared_context 'a drawing with sold tickets' do
  let!(:drawing) { create(:drawing, ticket_price: 25) }

  let!(:instant_prize) { create(:prize, prizeable: drawing, value: 10) }
  let!(:weekly_prize) { create(:prize, :weekly, prizeable: drawing, value: 1000) }

  let!(:entries) { create_list(:entry, 3, drawing: drawing) }

  let!(:tickets) do
    [
      create(:ticket, drawing: drawing, entry: nil),
      create(:ticket, drawing: drawing, entry: entries[0]),
      create(:ticket, drawing: drawing, entry: entries[1], prize: instant_prize),
      create(:ticket, drawing: drawing, entry: entries[2], prize: weekly_prize)
    ]
  end
end
