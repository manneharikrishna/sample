shared_examples Admin::PrizePoolForm do
  context 'without a tickets count' do
    before { params.delete('tickets_count') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['tickets_count']).to be_present
    end
  end

  context 'with an invalid tickets count' do
    before { params['tickets_count'] = 0 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['tickets_count']).to be_present
    end
  end

  context 'without a ticket price' do
    before { params.delete('ticket_price') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['ticket_price']).to be_present
    end
  end

  context 'with an invalid ticket price' do
    before { params['ticket_price'] = 0 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['ticket_price']).to be_present
    end
  end

  context 'when the tickets count exceeds the limit' do
    before { params['tickets_count'] = 1001 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['tickets_count']).to be_present
    end
  end

  context 'when the total revenue exceeds the limit' do
    before { params['ticket_price'] = 1001 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['total_revenue']).to be_present
    end
  end
end
