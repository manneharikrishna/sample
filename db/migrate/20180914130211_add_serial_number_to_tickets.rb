class AddSerialNumberToTickets < ActiveRecord::Migration[5.0]
  def change
    add_column :tickets, :serial_number, :uuid, null: false, default: 'gen_random_uuid()'
  end
end
