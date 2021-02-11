class RemoveReferencesFromFailedSessionAttempts < ActiveRecord::Migration[5.1]
  def change
    remove_reference :failed_session_attempts, :player, index: true, foreign_key: true
  end
end
