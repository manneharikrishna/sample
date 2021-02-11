class AddStatusToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :status, :string, default: 'pending'
  end
end
