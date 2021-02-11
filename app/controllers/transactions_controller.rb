class TransactionsController < BaseController
  include PaginationHelper

  def index
    transactions = TransactionsQuery.new(current_player, params).call
    meta = { total_pages: total_pages(transactions) }

    render json: transactions.includes(include), meta: meta, adapter: :json,
      include: include, each_serializer: TransactionSerializer
  end

  private

  def include
    { entry: { drawing: :prizes, tickets: :prize } }
  end
end
