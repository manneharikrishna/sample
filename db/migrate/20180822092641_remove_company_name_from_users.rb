class RemoveCompanyNameFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :company_name, :string
  end
end
