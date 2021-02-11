class AddCounterToFailedSessionAttempts < ActiveRecord::Migration[5.1]
  def change
    add_column :failed_session_attempts, :counter, :integer, default: 0
  end
end
