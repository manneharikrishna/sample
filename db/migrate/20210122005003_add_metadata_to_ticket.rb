class AddMetadataToTicket < ActiveRecord::Migration[5.1]
  def change
  	add_column :tickets, :scratch_state, :json, default: {}
  end
end
