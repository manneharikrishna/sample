class CreateColors < ActiveRecord::Migration[5.0]
  def change
    create_table :colors do |t|
      t.belongs_to :template, foreign_key: true
      t.string :name
      t.boolean :required, default: false

      t.timestamps
    end
  end
end
