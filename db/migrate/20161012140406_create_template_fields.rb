class CreateTemplateFields < ActiveRecord::Migration[5.0]
  def change
    create_table :template_fields do |t|
      t.belongs_to :template, foreign_key: true
      t.string :name
      t.integer :min_length
      t.integer :max_length

      t.timestamps
    end
  end
end
