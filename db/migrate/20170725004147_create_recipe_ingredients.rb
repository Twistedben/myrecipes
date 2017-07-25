class CreateRecipeIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_ingredients do |t|
#All this model will need is the two foreign keys to link the two tables
      t.integer :recipe_id
      t.integer :ingredient_id
    end
  end
end
