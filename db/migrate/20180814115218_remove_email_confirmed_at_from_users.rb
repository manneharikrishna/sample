class RemoveEmailConfirmedAtFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :email_confirmed_at, :datetime
  end
end
