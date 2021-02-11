class RemoveTeamFromMemberships < ActiveRecord::Migration[5.0]
  def change
    remove_reference :memberships, :team, foreign_key: true
  end
end
