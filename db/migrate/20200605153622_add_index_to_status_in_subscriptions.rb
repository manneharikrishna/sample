class AddIndexToStatusInSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_index :subscriptions, :status
  end
end
