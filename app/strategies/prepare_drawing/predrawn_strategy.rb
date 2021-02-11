class PrepareDrawing::PredrawnStrategy
  def initialize(drawing)
    @drawing = drawing
  end

  def call
    generate_tickets
    assign_prizes
  end

  private

  def generate_tickets
    GenerateTickets.new(@drawing).call
  end

  def assign_prizes
    AssignPrizes.new(@drawing).call
  end
end
