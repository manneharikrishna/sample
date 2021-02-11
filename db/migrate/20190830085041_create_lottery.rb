class CreateLottery < ActiveRecord::Migration[5.0]
  def change
    create_table :lotteries do |t|
      t.string :name
      t.string :headline
      t.string :description
      t.string :cover
      t.datetime :starts_at
      t.datetime :ends_at
      t.integer :tickets_count
      t.decimal :ticket_price, precision: 8, scale: 2
      t.integer :payback_ratio

      t.timestamps
    end
  end
end
