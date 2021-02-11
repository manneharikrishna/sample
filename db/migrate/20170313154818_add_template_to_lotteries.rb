class AddTemplateToLotteries < ActiveRecord::Migration[5.0]
  def change
    add_reference :lotteries, :template, foreign_key: false
  end
end
