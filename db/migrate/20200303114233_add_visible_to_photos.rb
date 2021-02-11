class AddVisibleToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :visible, :boolean, default: true
  end
end
