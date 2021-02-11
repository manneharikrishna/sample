EntryPolicy = Struct.new(:player, :drawing) do
  def create?
    drawing_ongoing?
  end

  def update?
    drawing_ongoing?
  end

  private

  def drawing_ongoing?
    drawing_started? && drawing_not_ended?
  end

  def drawing_started?
    drawing.status == :started
  end

  def drawing_not_ended?
    drawing.ends_at.future?
  end
end
