require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Ben", email: "Bensgamingmail@yahoo.com")
    @recipe = Recipe.create(name: "Vegetable Saute", description: "Great Vegetable Saute", chef: @chef)
  end 
  
  test 'reject invalid recipe update' do
    get edit_recipe_path(@recipe) #Rails routes shows us this prefix: edit_recipe, GET, /recipes/:id/edit(.:format).
    assert_template 'recipes/edit' #See if the edit template view is there.
#Below, Patch = Editting of Recipe. The path is derived from Rails ROutes PATCH. Params tells us what we're submitting.
    patch recipe_path(@recipe), params: { recipe: {name: "", description: "some description"} } #Should fail, name empty.
    assert_template 'recipes/edit' #Show the edit page again after the update from above with Flash messages 
#Below, we want to see if there are errors after the edit/update. We reuse the _messages partial, so same as recipes_test.
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test 'successfully edit a recipe' do
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
#Below, we create two variables for this test only
    updated_name = "updated recipe name"
    updated_description = "updated recipe description"
#Below, is posting a correct recipe update.
    patch recipe_path(@recipe), params: {recipe: {name: updated_name, description: updated_description}}
#Below, 'redirect' means goto show recipe path for this recipe, before we did "follow_redirect!", which is applicable too
    assert_redirected_to @recipe #@recipe is shortform for #show recipe's template.
#follow_redirect!   (Optional way to redirect page)
#Below, we want to make sure there is NO flash messages, because that means there are no errors = success.
    assert_not flash.empty?
#As of right now, our recipe doesn't have the newly inputted :name and :description from our variables, it has them from
#our def setup test instead, so we have to be sure these variables are passed to be updated.
    @recipe.reload #Reloads the recipe info, with new name and desc.
#Below, is similar to the assert_match we did in the 'recipes_test' under new recipe, instead of checking the HTML, we
#are checking the assigned values.
    assert_match updated_name, @recipe.name #Ensures the new variable :name is assigned to @recipe
    assert_match updated_description, @recipe.description #Ensures the new variable :description is assigned to @recipe
  end
  
end