class CreateEntry::PaidStrategy
  def initialize(entry, params)
    @entry = entry
    @drawing = entry.drawing
    @params = params
  end

  private

  def ensure_funds_sufficient
    VerifyBalance.new(@entry.player, amount).call
  end

  def verify_loss_limits
    VerifyLossLimits.new(@entry.player, amount).call
  end

  def create_payment
    CreatePayment.new(@entry, amount).call
  end

  def amount
    @amount ||= @drawing.lottery.ticket_price * @entry.tickets_count
  end
end
