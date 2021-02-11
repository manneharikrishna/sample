module StrategyHelper
  def strategy
    strategy_class.new(@drawing)
  end

  def strategy_class
    strategy_class_name.safe_constantize || NullStrategy
  end

  def strategy_class_name
    "#{self.class}::#{@drawing.lottery.type.classify}Strategy"
  end
end
