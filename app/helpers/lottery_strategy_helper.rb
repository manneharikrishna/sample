module LotteryStrategyHelper
  def strategy
    strategy_class.new(@lottery)
  end

  def strategy_class
    strategy_class_name.safe_constantize || NullStrategy
  end

  def strategy_class_name
    "#{self.class}::#{@lottery.type.classify}Strategy"
  end
end
