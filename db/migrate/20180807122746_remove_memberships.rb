class RemoveMemberships < ActiveRecord::Migration[5.0]
  def change
    drop_table :memberships do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :lottery,foreign_key: true

      t.string :role, default: 'operator'

      t.timestamps
    end
  end
end
