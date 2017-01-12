class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :create_recipes do |t|
      create_table :recipes do |t|
        t.string :name
        t.text :ingredients
        t.text :instructions
        t.integer :time_to_prepare
        t.integer :time_to_cook
        t.string :source_url

      t.timestamps
    end
  end
end
end
