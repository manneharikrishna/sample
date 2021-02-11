class CreateEntry::PoolStrategy < CreateEntry::PaidStrategy
  def call
    ensure_funds_sufficient
    verify_loss_limits
    create_payment
    create_tickets
  end

  private

  def create_tickets
    @entry.tickets_count.times { create_ticket }
  end

  def create_ticket
    @entry.tickets.create!(drawing: @drawing)
  end
end
