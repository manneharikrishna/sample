class WithdrawalsController < BaseController
  before_action :authorize_withdrawal
  before_action :verify_balance

  def create
    submit_form(WithdrawalForm.new(current_player))
  end

  private

  def authorize_withdrawal
    authorize(:withdrawal)
  end

  def verify_balance
    VerifyBalance.new(current_player, params[:amount]).call
  end
end
