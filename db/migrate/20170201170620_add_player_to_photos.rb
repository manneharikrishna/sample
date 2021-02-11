class AddPlayerToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_reference :photos, :player, foreign_key: true
  end
end
