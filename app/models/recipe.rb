class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 5, maximum: 500}
  belongs_to :chef #this is singular because it is the ONE side of the MANY side
  validates :chef_id, presence: true 
#Below shows recipes sorted by date in descending order
  default_scope -> { order(updated_at: :desc)}
#Below, sets up association between ingredients and recipe_ingredients
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
#Below, sets up one to many association between Comments, and if a recipe is destroyed, so are the comments
  has_many :comments, dependent: :destroy 

end 