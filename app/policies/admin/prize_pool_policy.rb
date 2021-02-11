Admin::PrizePoolPolicy = Struct.new(:operator, :drawing) do
  def update?
    drawing.status == :pending
  end
end
