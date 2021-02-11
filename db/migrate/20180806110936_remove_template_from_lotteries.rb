class RemoveTemplateFromLotteries < ActiveRecord::Migration[5.0]
  def change
    remove_reference :lotteries, :template, foreign_key: false
  end
end
