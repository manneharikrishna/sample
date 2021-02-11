class AddIndexToLotteryTransitions < ActiveRecord::Migration[5.0]
  def change
    add_index :lottery_transitions, :to_state
  end
end
