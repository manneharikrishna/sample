class ChangePrimaryKeyTypeInFailedSessionAttempts < ActiveRecord::Migration[5.1]
  def up
    change_column :failed_session_attempts, :id, :integer
  end

  def down
    change_column :failed_session_attempts, :id, :bigint
  end
end
