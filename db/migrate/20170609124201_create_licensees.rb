class CreateLicensees < ActiveRecord::Migration[5.0]
  def change
    create_table :licensees do |t|
      t.string :name
      t.string :email, index: true

      t.timestamps
    end
  end
end
