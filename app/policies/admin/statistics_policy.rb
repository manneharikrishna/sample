Admin::StatisticsPolicy = Struct.new(:operator, :drawing) do
  def show?
    [:started, :ended, :cancelled].include?(drawing.status)
  end
end
