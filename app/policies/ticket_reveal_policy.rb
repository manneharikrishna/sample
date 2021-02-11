TicketRevealPolicy = Struct.new(:player, :ticket) do
  def create?
    ticket_not_revealed? && drawing_has_ended?
  end

  private

  def ticket_not_revealed?
    !ticket.revealed?
  end

  def drawing_has_ended?
    ticket.drawing.ends_at.past?
  end
end
