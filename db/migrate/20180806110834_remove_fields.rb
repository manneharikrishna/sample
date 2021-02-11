class RemoveFields < ActiveRecord::Migration[5.0]
  def change
    drop_table :fields do |t|
      t.belongs_to :template, foreign_key: true
      t.string :name
      t.integer :min_length
      t.integer :max_length
      t.boolean :required, default: false

      t.timestamps
    end
  end
end
