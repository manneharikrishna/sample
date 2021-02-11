class AddPrizeableToPrizes < ActiveRecord::Migration[5.0]
  def change
    add_reference :prizes, :prizeable, polymorphic: true
  end
end
