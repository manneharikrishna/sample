require 'rails_helper'

RSpec.describe Consultancy::PlayersQuery do
  let(:player) do
    create(:player, email: 'example@player.com', first_name: 'Adam', last_name: 'Smith')
  end

  subject(:results) { described_class.new(param).call }

  context 'when the parameter is a full' do
    context 'email' do
      let(:param) { player.email }

      it 'finds provided email in the players database' do
        expect(results).to match_array(player)
      end
    end

    context 'first name' do
      let(:param) { player.first_name }

      it 'finds provided first name in the players database' do
        expect(results).to match_array(player)
      end
    end

    context 'last name' do
      let(:param) { player.last_name }

      it 'finds provided last name in the players database' do
        expect(results).to match_array(player)
      end
    end
  end

  context 'when the parameter is a part' do
    context 'part of email is provided' do
      let(:param) { 'exam' }

      it 'of email' do
        expect(results).to match_array(player)
      end
    end

    context 'of first name' do
      let(:param) { 'dam' }

      it 'finds by part of the first name' do
        expect(results).to match_array(player)
      end
    end

    context 'of last name' do
      let(:param) { 'smi' }

      it 'finds by part of the last name' do
        expect(results).to match_array(player)
      end
    end
  end

  context 'when the parameter is a non-existent' do
    context 'email' do
      let(:param) { 'nonexisting@player.com' }

      it 'returns nothing' do
        expect(results).to be_empty
      end
    end

    context 'first name' do
      let(:param) { 'Nonexisting' }

      it 'returns nothing' do
        expect(results).to be_empty
      end
    end

    context 'last name' do
      let(:param) { 'Player' }

      it 'returns nothing' do
        expect(results).to be_empty
      end
    end
  end
end
