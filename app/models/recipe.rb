class Recipe < ApplicationRecord
  belongs_to :recipe_book
  has_many :users, through: :recipe_book, class_name: User
end
