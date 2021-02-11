class AddExpiresOnToSubscription < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :expires_on, :date
  end
end
