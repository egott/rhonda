class Recipe < ApplicationRecord
  belongs_to :recipebook
  has_many :users, through: :recipebook, class_name: User
end
