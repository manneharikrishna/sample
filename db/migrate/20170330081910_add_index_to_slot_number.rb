class AddIndexToSlotNumber < ActiveRecord::Migration[5.0]
  def change
    add_index :default_photos, :slot_number
  end
end
