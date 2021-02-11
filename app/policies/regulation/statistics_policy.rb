Regulation::StatisticsPolicy = Struct.new(:regulator, :drawing) do
  def show?
    [:started, :ended, :cancelled].include?(drawing.status)
  end
end
