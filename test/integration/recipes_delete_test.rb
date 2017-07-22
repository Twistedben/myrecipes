require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Ben", email: "Bensgamingmail@yahoo.com",
                        password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Vegetable Saute", description: "Great Vegetable Saute", chef: @chef)
  end 
  
  test "successfully delete a recipe" do
    sign_in_as(@chef, "password")
    get recipe_path(@recipe) #First, see if Show route is available
    assert_template 'recipes/show' #See if Show view is available
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this Recipe"#See if HTML/ERB Delete is there
#Below, we test to see if the DB decreased in size by one, indicating a successful delete of a recipe 
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe) #Submit to recipe path as a delete action
    end
    assert_redirected_to recipes_path #Redirection to Show route page
    assert_not flash.empty? #Ensure that the Flash has appeared, indicating a successful delete
  end 
  
end
