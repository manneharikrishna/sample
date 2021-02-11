require 'rails_helper'

RSpec.describe 'Subscription API', nets: true do
  let(:headers) { authorization_header(:player) }
  let(:path) { '/subscription' }

  let!(:drawing) { create(:predrawn_lottery_drawing, :started, :with_tickets) }
  let!(:player) { current_player }
  let(:photo) { create(:photo, player: current_player) }

  describe 'GET /subscription' do
    let!(:subscription) { create(:subscription, :active, player: current_player) }

    subject! { get path, headers: headers }

    it 'returns the 200 status' do
      expect(response).to have_http_status(200)
    end

    it 'returns the subscription details' do
      expect(json_response['id']).to be_a(Numeric)
      expect(json_response['amount']).to be_present
      expect(json_response['tickets_count']).to be_present
      expect(json_response['photo_id']).to be_present
      expect(json_response['status']).to eq('active')
      expect(json_response['redirect_url']).to be_nil

      expect(json_response['payment_method']).to be_present
      expect(json_response['card_last_digits']).to be_present
      expect(json_response['card_expiration_date']).to be_present
      expect(json_response['nets_token']).not_to be_present
      expect(json_response['expires_on']).to be_present
    end
  end

  describe 'POST /subscription' do
    let(:params) do
      {
        tickets_count: 2,
        photo_id: photo.id,
        drawing_id: drawing.id,
        redirect_url: 'http://example.com/nets-redirect'
      }
    end

    let!(:deposit) { nil }

    subject! { post path, params: params, headers: headers }

    it 'returns the 201 status' do
      expect(response).to have_http_status(201)
    end

    it 'returns a subscription details' do
      expect(json_response['id']).to be_a(Numeric)
      expect(json_response['amount']).to be_present
      expect(json_response['tickets_count']).to be_present
      expect(json_response['photo_id']).to be_present
      expect(json_response['status']).to eq('inactive')
      expect(json_response['redirect_url']).to be_present

      expect(json_response['payment_method']).to be_nil
      expect(json_response['card_last_digits']).to be_nil
      expect(json_response['card_expiration_date']).to be_nil
      expect(json_response['nets_token']).not_to be_present
    end

    it 'returns the deposit details' do
      expect(json_response['deposit']['id']).to be_present
      expect(json_response['deposit']['status']).to be_present
    end

    it 'creates a subscription' do
      expect(Subscription.count).to eq(1)
    end

    it 'creates a deposit transaction' do
      expect(Deposit.count).to eq(1)
    end

    context 'when the player is suspended' do
      let(:player) { super().update!(suspended_until: 1.hour.from_now) }

      it 'returns the 403 status' do
        expect(response).to have_http_status(403)
      end
    end

    context 'when the drawing has ended' do
      let(:drawing) { create(:predrawn_lottery_drawing, :started, ends_at: 1.day.ago) }

      it 'returns the 403 status' do
        expect(response).to have_http_status(403)
      end
    end

    context 'when the loss limit is exceeded' do
      let(:player) { super().update!(daily_loss_limit: 1) }

      it 'returns the 403 status' do
        expect(response).to have_http_status(403)
      end

      it 'returns the error message' do
        expect(json_response['errors']).to contain_error(:loss_limit_exceeded)
      end
    end

    context 'when the balance limit is exceeded' do
      let(:deposit) { create(:deposit, amount: 10_000, player: current_player) }

      it 'returns the 403 status' do
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'PATCH /subscription' do
    let(:params) do
      {
        deposit_id: deposit.id,
        drawing_id: drawing.id
      }
    end

    let(:subscription) do
      create(:subscription, :inactive, player: current_player, tickets_count: 2)
    end

    let(:deposit) do
      create(:deposit, player: current_player, subscription: subscription, amount: 20)
    end

    subject! { patch path, params: params, headers: headers }

    context 'when player has no active subscriptions' do
      it 'returns the 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'returns the subscription details' do
        expect(json_response['id']).to be_a(Numeric)
        expect(json_response['amount']).to be_present
        expect(json_response['tickets_count']).to be_present
        expect(json_response['tickets_count']).to eq(2)

        expect(json_response['photo_id']).to be_present
        expect(json_response['status']).to eq('active')
        expect(json_response['redirect_url']).to be_nil

        expect(json_response['payment_method']).to be_present
        expect(json_response['card_last_digits']).to be_present
        expect(json_response['card_expiration_date']).to be_present
        expect(json_response['nets_token']).not_to be_present
        expect(json_response['expires_on']).to be_present
      end

      it 'returns the deposit details' do
        expect(json_response['deposit']['id']).to be_present
        expect(json_response['deposit']['status']).to be_present
      end

      it 'activates the subscription' do
        expect(subscription.reload.status).to eq('active')
      end

      it 'completes the subscription deposit' do
        expect(deposit.status).to eq('completed')
      end
    end

    context 'when the payment is not authorized' do
      let(:deposit) do
        create(:deposit,
          player: current_player,
          subscription: subscription,
          nets_payment_id: 'unauthorized-cancelled')
      end

      it 'returns the cancelled deposit status' do
        expect(json_response['deposit']['status']).to eq('cancelled')
      end
    end

    context 'when the player is suspended' do
      let(:player) { super().update!(suspended_until: 1.hour.from_now) }

      it 'returns the 403 status' do
        expect(response).to have_http_status(403)
      end
    end

    context 'when the drawing has ended' do
      let(:drawing) { create(:predrawn_lottery_drawing, :started, ends_at: 1.day.ago) }

      it 'returns the 403 status' do
        expect(response).to have_http_status(403)
      end
    end

    context 'when player already has active subscription' do
      let(:subscription) do
        create(:subscription, :active, player: current_player, tickets_count: 5)
      end

      it 'returns the 200 status' do
        expect(response).to have_http_status(200)
      end

      it 'returns the current subscription details' do
        expect(json_response['id']).to be_a(Numeric)
        expect(json_response['amount']).to be_present
        expect(json_response['tickets_count']).to be_present
        expect(json_response['tickets_count']).to eq(5)

        expect(json_response['photo_id']).to be_present
        expect(json_response['status']).to eq('active')
        expect(json_response['redirect_url']).to be_nil

        expect(json_response['payment_method']).to be_present
        expect(json_response['card_last_digits']).to be_present
        expect(json_response['card_expiration_date']).to be_present
        expect(json_response['nets_token']).not_to be_present
        expect(json_response['expires_on']).to be_present
      end
    end
  end
end
