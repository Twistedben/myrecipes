class RecipeIngredient < ApplicationRecord
#Below, we set this model to belong to both the "ingredient.rb" and "recipe.rb".
  belongs_to :ingredient
  belongs_to :recipe
end