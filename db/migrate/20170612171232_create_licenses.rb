class CreateLicenses < ActiveRecord::Migration[5.0]
  def change
    create_table :licenses do |t|
      t.belongs_to :licensee, foreign_key: true
      t.string :name
      t.string :lottery_type

      t.timestamps
    end
  end
end
