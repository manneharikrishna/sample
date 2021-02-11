class AddMaxTicketsCountToLicenses < ActiveRecord::Migration[5.0]
  def change
    add_column :licenses, :max_tickets_count, :integer
  end
end
