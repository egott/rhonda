class Changerecipes < ActiveRecord::Migration[5.0]
  def change
    change_table :recipes do |t|
      t.remove :instructions
      t.string :instructions
      t.string :ingredient_name
    end
  end
end
