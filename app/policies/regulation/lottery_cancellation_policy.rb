Regulation::LotteryCancellationPolicy = Struct.new(:regulator, :lottery) do
  def create?
    [:ready, :started].include?(lottery.status)
  end
end
