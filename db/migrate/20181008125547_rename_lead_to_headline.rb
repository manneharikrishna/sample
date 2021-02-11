class RenameLeadToHeadline < ActiveRecord::Migration[5.0]
  def change
    rename_column :lotteries, :lead, :headline
  end
end
