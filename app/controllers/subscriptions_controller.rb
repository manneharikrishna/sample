class SubscriptionsController < BaseController
  before_action :ensure_player_not_suspended, only: [:create, :update]
  before_action :authorize_entry, only: [:create, :update]

  before_action :set_amount, only: :create

  before_action :verify_loss_limits, only: :create
  before_action :verify_balance_limit, only: :create
  before_action :verify_transfer_limit, only: :create

  before_action :authorize_subscription, only: :create

  def show
    render json: active_subscription
  end

  def create
    submit_form(SubscriptionForm.new(current_player))
  end

  def update
    unless active_subscription.present?
      VerifySubscription.new(subscription, deposit, drawing).call
    end
    render json: subscription
  end

  private

  def drawing
    @drawing ||= Drawing.find(params[:drawing_id])
  end

  def set_amount
    params[:amount] = amount
  end

  def amount
    params[:tickets_count].to_i * drawing.lottery.ticket_price.to_i
  end

  def subscription
    deposit.subscription
  end

  def deposit
    @deposit ||= current_player.deposits.find(params[:deposit_id])
  end

  def authorize_subscription
    error_message = ResponseError.new(:forbidden, :subscription_limit)
    raise error_message if active_subscription.present?
  end

  def active_subscription
    @active_subscription ||= PlayerSubscriptionQuery.new(current_player).call
  end
end
