class CreateWinning::SocialStrategy
  def initialize(drawing, ticket)
    @drawing = drawing
    @ticket = ticket
  end

  def call
    selected_ticket || random_ticket
  end

  private

  def selected_ticket
    @ticket if entry_approved?
  end

  def entry_approved?
    @ticket&.entry&.status == 'approved'
  end

  def random_ticket
    @drawing.tickets.approved.random
  end
end
