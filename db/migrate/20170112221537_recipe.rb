class Recipe < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :ingredients
      t.text :instructions
      t.integer :time_to_cook
      t.integer :time_to_prepare
      t.string :source_url

      t.timestamps
    end
  end
end
