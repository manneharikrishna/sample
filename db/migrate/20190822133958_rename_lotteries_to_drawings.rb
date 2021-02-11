class RenameLotteriesToDrawings < ActiveRecord::Migration[5.0]
  def change
    rename_table :lotteries, :drawings
  end
end
