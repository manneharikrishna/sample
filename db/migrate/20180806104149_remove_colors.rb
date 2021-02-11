class RemoveColors< ActiveRecord::Migration[5.0]
  def change
    drop_table :colors do |t|
      t.belongs_to :template, foreign_key: true
      t.string :name
      t.boolean :required, default: false

      t.timestamps
    end
  end
end
