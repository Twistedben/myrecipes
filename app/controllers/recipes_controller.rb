class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.all
  end 
  
  def show
    @recipe = Recipe.find(params[:id])
  end 
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params) #recipe_params is the method defined under "private"
    @recipe.chef = Chef.first #A chef must be associated with a recipe so temporarily we just associate it with the current first chef
    if @recipe.save #If it saves, display Flash message success, if not move to 'else'
      flash[:success] = "Recipe was created successfully!" #Shows a Flash message of success
      redirect_to recipe_path(@recipe) #Redirects to the Show recipe path page
    else
      render 'new' #Reload the New template with errors
    end 
  end
  
  private
  
  def recipe_params #Whitelisting what we pass in 
    params.require(:recipe).permit(:name, :description)
  end
  
end 