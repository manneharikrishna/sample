shared_examples CreateEntry::PaidStrategy do
  context 'with insufficient funds' do
    before do
      create(:payment, amount: -100, player: entry.player)
    end

    it 'raises an error' do
      expect { subject.call }.to raise_error(ResponseError)
    end
  end

  context 'with insufficient funds' do
    before do
      create(:payment, amount: -100, player: entry.player)
    end

    it 'raises an error' do
      expect { subject.call }.to raise_error(ResponseError)
    end
  end

  context 'when a loss limit is exceeded' do
    let(:drawing) { create(:pool_lottery_drawing, ticket_price: amount) }
    let(:amount) { daily_loss_limit + 100 }

    let(:daily_loss_limit) { Limits.daily_loss_limit }

    it 'raises an error' do
      expect { subject.call }.to raise_error(ResponseError)
    end
  end
end
