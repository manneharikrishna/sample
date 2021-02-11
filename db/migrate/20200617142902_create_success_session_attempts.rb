class CreateSuccessSessionAttempts < ActiveRecord::Migration[5.1]
  def change
    create_table :success_session_attempts do |t|
      t.integer :counter, default: 0

      t.timestamps
    end
  end
end
