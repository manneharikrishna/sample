class RemovePayments < ActiveRecord::Migration[5.0]
  def change
    drop_table :payments do |t|
      t.belongs_to :entry, foreign_key: true
      t.decimal :amount, precision: 12, scale: 2

      t.timestamps
    end
  end
end
