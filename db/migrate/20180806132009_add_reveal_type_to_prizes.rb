class AddRevealTypeToPrizes < ActiveRecord::Migration[5.0]
  def change
    add_column :prizes, :reveal_type, :string, null: false, default: 'instant'
  end
end
