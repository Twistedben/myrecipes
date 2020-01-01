#we are inheriting the test_helper
require 'test_helper'

#since it's a test, name it the model name followed by Test and subclass the following
class RecipeTest < ActiveSupport::TestCase
  #setup (a key method) runs before all of your tests are run, one by one, before every one test. 
  def setup
    #first we start with an instance variable
    @chef = Chef.create!(chefname: "Ben", email: "bensgamingmail@yahoo.com",
                         password: "password", password_confirmation: "password")
    @recipe = @chef.recipes.build(name: "vegetable", description: "Great vegetable recipe")
  end
  
  test "recipe without chef should be invalid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  test 'recipe should be valid' do
    assert @recipe.valid?
  end
  
  test "name should be present" do
    #if we're testing if name should be present, then unlike the top test where we gave the instance
    #variable a name: "vegetable", we should make it empty
    @recipe.name = " "
    assert_not @recipe.valid?
    #we're asserting here that the recipe is NOT valid if the name is not present
  end
  
  test "description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "description shouldn't be less than 5 characters" do
    #
    @recipe.description = "a" * 3
    assert_not @recipe.valid?
  end 
  
  test "description shouldn't be more than 500 characters" do
    #
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end
  
end 