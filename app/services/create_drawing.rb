class CreateDrawing
  def initialize(lottery)
    @lottery = lottery
  end

  def call
    create_drawing.tap { |d| copy_lottery_prizes(d) }
  end

  private

  attr_reader :lottery

  def create_drawing
    lottery.drawings.create! do |drawing|
      drawing.name = "#{lottery.name} ##{drawing_ordinal_number}"

      drawing.starts_at = calculate_drawing_start
      drawing.ends_at = calculate_drawing_end
    end
  end

  def drawing_ordinal_number
    lottery.drawings.count + 1
  end

  def calculate_drawing_start
    CalculateDrawingStart.new(lottery).call
  end

  def calculate_drawing_end
    CalculateDrawingEnd.new(lottery).call
  end

  def copy_lottery_prizes(drawing)
    drawing.prizes = lottery.prizes.map(&:dup)
  end
end
