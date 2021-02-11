class RenameEndTimeToEndsAt < ActiveRecord::Migration[5.0]
  def change
    rename_column :lotteries, :end_time, :ends_at
  end
end
