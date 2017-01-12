class User < ApplicationRecord
  belongs_to :recipe_book
  has_many :recipes, through: :recipe_book, class_name: Recipe
end
