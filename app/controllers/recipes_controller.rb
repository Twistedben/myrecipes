class RecipesController < ApplicationController
#Below, before_action runs first everytime an action is called. Here we run "set_recipe" method defined in 
#the Private section to find and set_recipe solely for the actions listed after "only:" in square brackets [] 
before_action :set_recipe, only: [:show, :edit, :update]
  
  def index
    @recipes = Recipe.all
  end 
  
  def show
    
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
  
  def edit
    
  end 
  
  def update

    if @recipe.update(recipe_params)
      flash[:success] = "Recipe was updated successfully!"
      redirect_to recipe_path(@recipe)
    else 
      render 'edit'
    end 
  end 
  
  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe deleted successfully!"
    redirect_to recipes_path
  end
  
  private
  
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
  
  def recipe_params #Whitelisting what we pass in 
    params.require(:recipe).permit(:name, :description)
  end
  
end 