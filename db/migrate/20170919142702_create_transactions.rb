class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.belongs_to :player, foreign_key: true
      t.string :type
      t.decimal :amount, precision: 12, scale: 2
    end
  end
end
