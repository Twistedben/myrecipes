class ChefsController < ApplicationController
  before_action :set_chef, only: [:show, :edit, :update, :delete]
  
  def index
#Here, we are adding pagination to CHefs listing in Index
    @chefs = Chef.paginate(page: params[:page], per_page: 5) 
  end
  
  def new
    @chef = Chef.new
  end 
  
  def create
   @chef = Chef.new(chef_params)
   if @chef.save
     session[:chef_id] = @chef.id #This will automatically log in the chef after they create an account
     flash[:success] = "Welcome #{@chef.chefname} to MyRecipes App!"
     redirect_to chef_path(@chef)
   else 
     render 'new'
   end 
  end
  
  def show
#Below, we define a second variable to hold the recipes from the first and paginate
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end 
  
  def edit
  end
  
  def update
    if @chef.update(chef_params)
      flash[:success] = "Your account was updated!"
      redirect_to @chef 
    else 
      render 'edit'
    end 
  end
  
  def destroy
    @chef.destroy
    flash[:danger] = "Chef and All associated Recipes have been deleted"
    redirect_to chefs_path
  end
  
  private
  
  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end 
  
  def set_chef
     @chef = Chef.find(params[:id])
  end
  
end 