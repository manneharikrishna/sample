class RemovePhotoFromTickets < ActiveRecord::Migration[5.0]
  def change
    remove_reference :tickets, :photo, foreign_key: true
  end
end
