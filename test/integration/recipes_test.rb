require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    #first start with creating the chef, then next code line creates recipe
    @chef = Chef.create!(chefname: "Ben", email: "Bensgamingmail@yahoo.com")
    #Code below includes the chef: since recipes are belonging to chef, assigning recipe to chef above
    @recipe = Recipe.create(name: "Vegetable Saute", description: "Great Vegetable Saute", chef: @chef)
    #the two lines of code below are alternative way of doing the one line above
    #since build doesn't hit database, you have to specify the instance variable to save to DB
    #better way of doing it is above two lines code, the .create! hits database immediately
    @recipe2 = @chef.recipes.build(name: "Chicken Saute", description: "Great Chicken") 
    @recipe2.save
  end 
  
  test "should get recipe index" do 
    get recipes_url #This is the index as shown by our routes, so "/recipes"
    assert_response :success #This is saying we want a response that is considered a success "200"
  end 
  
  test "should get recipes listing" do 
    get recipes_path #We want to see the recipes listed so first get to the index path
    assert_template 'recipes/index'
    #We want to assert the view, so template, then the file path of that template in ''
    assert_match @recipe.name, response.body #we simply want to see the recipe's name in the browser
    #so assert_match will see if that following recipe's name is shown, and we want it to show in the 
    #body of the index page by using the "response.body"
    assert_match @recipe2.name, response.body
  end
 
end
