class RemovePresentations < ActiveRecord::Migration[5.0]
  def change
    drop_table :presentations do |t|
      t.belongs_to :template, foreign_key: true
      t.belongs_to :lottery, foreign_key: true

      t.hstore :fields, default: {}
      t.hstore :colors, default: {}
      t.hstore :logos, default: {}

      t.timestamps
    end
  end
end
