class PrizesTotalValueValidator < ActiveModel::Validator
  def validate(lottery)
    return if lottery.total_revenue.nil?

    prizes_total_value = prizes_total_value(lottery)

    if prizes_total_value > lottery.total_revenue
      lottery.errors.add(:base, :total_revenue_exceeded)
    end
  end

  private

  def prizes_total_value(lottery)
    lottery.prizes.sum(&:total_value)
  end
end
