Admin::DrawingPolicy = Struct.new(:operator, :drawing) do
  def update?
    drawing_pending?
  end

  def destroy?
    drawing_pending?
  end

  private

  def drawing_pending?
    drawing.status == :pending
  end
end
