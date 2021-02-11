class BalancesController < BaseController
  def show
    balance = CalculateBalance.new(current_player).call
    render json: { balance: balance }
  end
end
