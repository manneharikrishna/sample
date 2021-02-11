class RemoveStatusFromTickets < ActiveRecord::Migration[5.0]
  def change
    remove_column :tickets, :status, :string, default: 'pending'
  end
end
