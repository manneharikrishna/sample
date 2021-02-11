class CreateEntry::PredrawnStrategy < CreateEntry::PaidStrategy
  def call
    ensure_funds_sufficient
    verify_loss_limits
    ensure_tickets_available
    create_payment
    assign_tickets
    reveal_entry unless subscription_entry?
  end

  private

  def ensure_tickets_available
    if tickets.count != @entry.tickets_count
      raise ResponseError, :gone
    end
  end

  def assign_tickets
    tickets.each { |t| t.update(entry: @entry) }
  end

  def tickets
    @tickets ||= available_tickets.next(@entry.tickets_count)
  end

  def available_tickets
    @drawing.tickets.where(entry: nil)
  end

  def subscription_entry?
    @entry.entry_type == 'subscription'
  end

  def reveal_entry
    RevealEntry.new(@entry).call
  end
end
