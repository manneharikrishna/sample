shared_examples Regulation::LicenseForm do
  context 'without a name' do
    before { params.delete('name') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['name']).to be_present
    end
  end

  context 'when the name is already used' do
    before { create(:license, name: params['name']) }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['name']).to be_present
    end
  end

  context 'when the name is already used' do
    let(:license) { create(:license) }

    before { create(:license, name: params['name']) }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['name']).to be_present
    end
  end

  context 'with an invalid minimum duration' do
    before { params['min_duration'] = 0 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['min_duration']).to be_present
    end
  end

  context 'with an invalid maximum duration' do
    before { params['max_duration'] = 0 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['max_duration']).to be_present
    end
  end

  context 'with an invalid maximum tickets count' do
    before { params['max_tickets_count'] = 0 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['max_tickets_count']).to be_present
    end
  end

  context 'with an invalid maximum total revenue' do
    before { params['max_total_revenue'] = 0 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['max_total_revenue']).to be_present
    end
  end

  context 'with an invalid minimum payback ratio' do
    before { params['min_payback_ratio'] = 101 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['min_payback_ratio']).to be_present
    end
  end

  context 'with an invalid maximum payback ratio' do
    before { params['max_payback_ratio'] = 101 }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['max_payback_ratio']).to be_present
    end
  end
end
