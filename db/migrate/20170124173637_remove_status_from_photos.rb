class RemoveStatusFromPhotos < ActiveRecord::Migration[5.0]
  def change
    remove_column :photos, :status, :string, default: 'pending'
  end
end
