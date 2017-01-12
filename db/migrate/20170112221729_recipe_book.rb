class RecipeBook < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_books do |t|
      t.references :user
      t.references :recipe
    end
  end
end
