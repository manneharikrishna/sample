class RemoveLicensees < ActiveRecord::Migration[5.0]
  def change
    drop_table :licensees do |t|
      t.string :name
      t.string :email, index: true

      t.timestamps
    end
  end
end
