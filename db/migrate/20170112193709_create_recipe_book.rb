class CreateRecipeBook < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_books do |t|
      t.references :recipe
      t.references :user
    end
  end
end
