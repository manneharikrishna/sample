class Admin::WithdrawalsController < Admin::BaseController
  def index
    withdrawals = Withdrawal.order(created_at: :desc)
    render json: withdrawals.includes(:player)
  end
end
