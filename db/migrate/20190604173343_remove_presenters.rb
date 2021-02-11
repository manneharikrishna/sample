class RemovePresenters < ActiveRecord::Migration[5.0]
  def change
    drop_table :presenters do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
