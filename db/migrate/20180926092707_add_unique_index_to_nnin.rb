class AddUniqueIndexToNnin < ActiveRecord::Migration[5.0]
  def change
    add_index :players, :nnin, unique: true
  end
end
