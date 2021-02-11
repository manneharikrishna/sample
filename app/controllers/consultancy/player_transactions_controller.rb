class Consultancy::PlayerTransactionsController < Consultancy::BaseController
  def index
    transactions = Consultancy::PlayerTransactionsQuery.new(player, params).call
    render json: transactions, each_serializer: Consultancy::TransactionSerializer
  end

  private

  def player
    @player ||= Player.find(params[:player_id])
  end
end
