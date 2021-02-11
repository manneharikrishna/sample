class CreateAccountants < ActiveRecord::Migration[5.1]
  def change
    create_table :accountants, id: :integer do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
