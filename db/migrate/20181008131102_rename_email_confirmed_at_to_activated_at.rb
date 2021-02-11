class RenameEmailConfirmedAtToActivatedAt < ActiveRecord::Migration[5.0]
  def change
    rename_column :players, :email_confirmed_at, :activated_at
  end
end
