Admin::ModerationPolicy = Struct.new(:operator, :drawing) do
  def index?
    [:started, :ended, :cancelled].include?(drawing.status)
  end

  def update?
    [:started, :ended].include?(drawing.status)
  end
end
