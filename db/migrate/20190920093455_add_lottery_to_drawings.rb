class AddLotteryToDrawings < ActiveRecord::Migration[5.0]
  def change
    add_reference :drawings, :lottery, foreign_key: true
  end
end
