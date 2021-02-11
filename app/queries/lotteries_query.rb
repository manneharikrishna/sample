class LotteriesQuery
  def call
    Lottery.order(ends_at: :desc)
  end
end
