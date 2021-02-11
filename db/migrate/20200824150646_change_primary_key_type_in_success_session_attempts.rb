class ChangePrimaryKeyTypeInSuccessSessionAttempts < ActiveRecord::Migration[5.1]
  def up
    change_column :success_session_attempts, :id, :integer
  end

  def down
    change_column :success_session_attempts, :id, :bigint
  end
end
