class CreateEntry::SocialStrategy
  def initialize(entry, _params)
    @entry = entry
    @drawing = entry.drawing
  end

  def call
    override_tickets_count
    create_ticket
  end

  private

  def override_tickets_count
    @entry.update!(tickets_count: 1)
  end

  def create_ticket
    @entry.tickets.create!(drawing: @drawing)
  end
end
