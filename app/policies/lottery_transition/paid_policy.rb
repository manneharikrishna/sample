class LotteryTransition::PaidPolicy
  def initialize(lottery)
    @lottery = lottery
  end

  def final?
    required_attributes.all? { |ra| @lottery[ra].present? }
  end

  private

  def required_attributes
    [:tickets_count, :ticket_price]
  end
end
