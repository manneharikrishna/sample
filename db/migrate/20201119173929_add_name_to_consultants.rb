class AddNameToConsultants < ActiveRecord::Migration[5.1]
  def change
    add_column :consultants, :name, :string
  end
end
