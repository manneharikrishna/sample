class DepositsController < BaseController
  before_action :ensure_player_not_suspended

  before_action :verify_balance_limit, only: :create
  before_action :verify_transfer_limit, only: :create

  def create
    submit_form(DepositForm.new(current_player))
  end

  def update
    Deposits::Verify.new(deposit).call
    render json: deposit
  end

  private

  def deposit
    @deposit ||= current_player.deposits.find(params[:id])
  end
end
