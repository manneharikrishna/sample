class Consultancy::PlayerTransactionsQuery < ApplicationQuery
  def initialize(player, params)
    @player = player
    @params = params
  end

  def call
    paginate(player_transactions)
  end

  private

  def player_transactions
    @player.transactions
  end

  def paginate(relation)
    PaginationQuery.new(relation, @params[:page], @params[:per_page]).call
  end
end
