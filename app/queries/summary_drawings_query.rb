
class SummaryDrawingsQuery
  def call
    drawings.any? ? drawings : []
  end

  private

  def drawings
    (last_drawing + current_drawing).compact
  end

  def last_drawing
    [Drawing.in_state(:ended).last]
  end

  def current_drawing
    DrawingsQuery.new.call
  end
end
