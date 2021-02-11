class CalculatePaybackRatio
  delegate :prizes, to: :@form
  delegate :total_revenue, to: :@form

  def initialize(prize_pool_form)
    @form = prize_pool_form
  end

  def call
    return unless prizes.present? && total_revenue
    prizes_total_value / total_revenue * 100
  end

  private

  def prizes_total_value
    prizes.sum(&:total_value).to_d
  end
end
