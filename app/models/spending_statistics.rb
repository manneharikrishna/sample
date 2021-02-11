class SpendingStatistics
  include ActiveModel::Serialization

  def initialize(drawing)
    @drawing = drawing
  end

  def lowest_spending
    payments.maximum(:amount)&.abs || 0.to_d
  end

  def highest_spending
    payments.minimum(:amount)&.abs || 0.to_d
  end

  def average_spending
    payments.average(:amount)&.abs || 0.to_d
  end

  private

  def payments
    @drawing.payments.where(<<~SQL)
      EXISTS(SELECT 1 FROM tickets WHERE entry_id = entries.id)
    SQL
  end
end
