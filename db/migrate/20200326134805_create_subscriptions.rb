class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions, id: :integer do |t|
      t.belongs_to :player, foreign_key: true, type: :integer
      t.belongs_to :photo, foreign_key: true,  type: :integer
      t.integer :tickets_count
      t.string :status, default: 'inactive'
      t.string :payment_method
      t.string :card_expiration_date
      t.string :card_last_digits
      t.jsonb :data

      t.timestamps
    end
  end
end
