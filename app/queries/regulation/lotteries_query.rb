class Regulation::LotteriesQuery < ApplicationQuery
  def call
    sort_by_end_time(lotteries)
  end

  private

  def lotteries
    Lottery.not_in_state(:pending, :final)
  end

  def sort_by_end_time(relation)
    SortingQuery.new(relation, :ends_at, :desc).call
  end
end
