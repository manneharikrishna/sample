class PrizePoolFormFactory
  def initialize(lottery)
    @lottery = lottery
  end

  def create
    prize_pool_form_class.new(@lottery)
  end

  private

  def prize_pool_form_class
    prize_pool_form_class_name.constantize
  end

  def prize_pool_form_class_name
    "Admin::#{@lottery.type.classify}PrizePoolForm"
  end
end
