class RemoveTeams < ActiveRecord::Migration[5.0]
  def change
    drop_table :teams do |t|
      t.string :name

      t.timestamps
    end
  end
end
