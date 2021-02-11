class PrizesQuantityValidator < ActiveModel::Validator
  def validate(lottery)
    return if lottery.tickets_count.nil?

    prizes_quantity = prizes_quantity(lottery)

    if prizes_quantity > lottery.tickets_count
      lottery.errors.add(:base, :tickets_count_exceeded)
    end
  end

  private

  def prizes_quantity(lottery)
    lottery.prizes.sum(&:quantity)
  end
end
