Regulation::DrawingCancellationPolicy = Struct.new(:regulator, :drawing) do
  def create?
    [:ready, :started].include?(drawing.status)
  end
end
