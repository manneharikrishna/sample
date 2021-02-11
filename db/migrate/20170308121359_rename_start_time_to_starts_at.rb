class RenameStartTimeToStartsAt < ActiveRecord::Migration[5.0]
  def change
    rename_column :lotteries, :start_time, :starts_at
  end
end
