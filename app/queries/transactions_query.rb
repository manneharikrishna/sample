class TransactionsQuery < ApplicationQuery
  def initialize(player, params)
    @player = player
    @params = params
  end

  def call
    paginate(sort_by_creation_time(filter_by_transaction_status(@player.transactions)))
  end

  private

  def filter_by_transaction_status(relation)
    relation.where(status: %w[pending completed failed])
  end

  def sort_by_creation_time(relation)
    relation.order(created_at: :desc)
  end

  def paginate(relation)
    PaginationQuery.new(relation, @params[:page], @params[:per_page]).call
  end
end
