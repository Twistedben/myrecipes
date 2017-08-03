class RecipesController < ApplicationController
#Below, before_action runs first everytime an action is called. Here we run "set_recipe" method defined in 
#the Private section to find and set_recipe solely for the actions listed after "only:" in square brackets [] 
before_action :set_recipe, only: [:show, :edit, :update, :destroy]
#Below, we're calling "require_user" from "application_controller" to allow visitors only to see Index and Show
before_action :require_user, except: [:index, :show]
#Below, restricts only the usre who created the recipe to edit, update, or destroy it.
before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index #Below we allow pagination to Recipe's all and set it to 5 per page
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end 
  
  def show
    @comments = @recipe.comments.paginate(page: params[:page], per_page: 5)
    @comment = Comment.new #This allows new comments within /recipe/show.html.erb 
  end 
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params) #recipe_params is the method defined under "private"
    @recipe.chef = current_chef #Recipe will be created by the current logged in Chef.
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
  
  def recipe_params #Whitelisting what we pass in: the name, description, and now ingredients' IDs 
    params.require(:recipe).permit(:name, :description, ingredient_ids: [] )
  end
#Now, we build a method to allow only the user who created the associated recipe to be able to modify it.
  def require_same_user
#Below, the if statement is if the logged in chef is not equal to the recipe's associated chef owner, then you get 
#a error flash message and redirected to the recipes show page. We also add if the logged in user is NOT an admin.
    if current_chef != @recipe.chef and !current_chef.admin?
      flash[:danger] = "You can only modify your own recipes!"
      redirect_to recipes_path
    end
  end
  
end 