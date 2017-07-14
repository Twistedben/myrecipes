require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    #first start with creating the chef, then next code line creates recipe
    @chef = Chef.create!(chefname: "Ben", email: "Bensgamingmail@yahoo.com",
                         password: "password", password_confirmation: "password")
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
    get recipes_path 
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name#We use assert_select to look for something: 
#the HTML/CSS we're looking for (in this case a link), then what link specifically (URL path of the Recipe), and
#then the specific text behind the link (in this case the Recipe's Name)
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end
  
  test "should get recipes show" do 
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body #Checks if Recipe's name is present on show page
    assert_match @recipe.description, response.body #Checks if Recipe's Description is present
    assert_match @chef.chefname, response.body #CHecks if chef's name is present on page
    assert_select 'a[href=?]', edit_recipe_path(@recipe), text: 'Edit this Recipe' #Expecting show page to have a link to
#edit the existing recipe, a link that would take you to that route "edit_recipe_path" with that show ID (@recipe) and the
#link will have the text 'Edit this Recipe'
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this Recipe"#Expecting Show to have a Delete link
    assert_select 'a[href=?]', recipes_path, text: "Return to Recipe's Listing" #Expecting btn link to return
  end
 
  test "create new valid recipe" do 
    get new_recipe_path
    assert_template 'recipes/new' #Test for the existence of new page view.
    name_of_recipe = "chicken saute" #Defining a Test variable for recipe name.
    description_of_recipe = "Add, chicked and vegetables, cook for 20 minutes" #Defining a Test variable for Description.
#We want the database to increase since a successful save will do so, ;Recipe.count, Increase by 1 in a Do block    
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: {recipe:{name: name_of_recipe, description: description_of_recipe}} #Name of our variables
    end 
    follow_redirect! #Which refers to the "redirect_to" method we have in our controller under the "Create" action.
    assert_match name_of_recipe.titleize, response.body #Expectation of the recipe's name titileized in the Body.
    assert_match description_of_recipe, response.body #Same as above but with Description and no titleized.
  end
  
  test "reject invalid recipe submissions" do
    get new_recipe_path
    assert_template 'recipes/new' #We now this is good because we already have the New Form view
    assert_no_difference 'Recipe.count' do #Seeing if no change occured to DB
      post recipes_path, params: {recipe: {name: "", description: ""}}#Submits form with no info filled in, so it should fail
    end
    assert_template 'recipes/new' #Meaning we should get new form again with errors listed, and if below two tags "h2 & div"
    assert_select 'h2.panel-title' #with panel-title class and panel-body class appear, we know we have an error
    assert_select 'div.panel-body' #Errors listed
  end 
  
end
