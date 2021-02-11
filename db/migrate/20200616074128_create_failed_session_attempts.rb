class CreateFailedSessionAttempts < ActiveRecord::Migration[5.1]
  def change
    create_table :failed_session_attempts do |t|
      t.belongs_to :player, foreign_key: true, index: true, type: :integer

      t.timestamps
    end
  end
end
