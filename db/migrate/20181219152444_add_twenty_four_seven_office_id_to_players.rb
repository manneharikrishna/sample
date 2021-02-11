class AddTwentyFourSevenOfficeIdToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :twenty_four_seven_office_id, :integer
  end
end
