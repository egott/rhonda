class Recipe < ApplicationRecord
  has_many :recipe_books
  has_many :users, through: :recipe_books
end
