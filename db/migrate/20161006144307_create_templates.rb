class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.string :name
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
