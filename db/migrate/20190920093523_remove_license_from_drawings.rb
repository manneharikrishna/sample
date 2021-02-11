class RemoveLicenseFromDrawings < ActiveRecord::Migration[5.0]
  def change
    remove_reference :drawings, :license, foreign_key: true
  end
end
