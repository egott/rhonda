class CreateRecipeBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :create_recipe_books do |t|
      t.references :recipe
      t.references :user

      t.timestamps
    end
  end
end
