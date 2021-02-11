class RenameLotteryTransitionsToDrawingTransitions < ActiveRecord::Migration[5.0]
  def change
    rename_table :lottery_transitions, :drawing_transitions

    rename_column :drawing_transitions, :lottery_id, :drawing_id

    remove_index :drawing_transitions, name: "index_lottery_transitions_parent_most_recent"
    remove_index :drawing_transitions, name: "index_lottery_transitions_parent_sort"

    add_index(:drawing_transitions, [:drawing_id, :sort_key], unique: true,
      name: 'index_drawing_transitions_parent_sort')

    add_index(:drawing_transitions, [:drawing_id, :most_recent], unique: true,
      where: 'most_recent', name: 'index_drawing_transitions_parent_most_recent')
  end
end
