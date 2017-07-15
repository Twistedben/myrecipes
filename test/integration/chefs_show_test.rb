require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  
  def setup
      @chef = Chef.create!(chefname: "Ben", email: "Bensgamingmail@yahoo.com",
                         password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Vegetable Saute", description: "Great Vegetable Saute", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chicken Saute", description: "Great Chicken") 
    @recipe2.save
  end 

  test "should get chef's show" do
#Testing to ensure only recipes associated with chef show up and link to individual recipe's work
    get chef_path(@chef)
    assert_template 'chefs/show'
#Below, test to ensure recipe links are there and working
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
#Below, we want to ensure recipes' descriptions are showing and the chef's name 
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end
 
  
end
