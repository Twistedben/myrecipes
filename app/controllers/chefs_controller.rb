class ChefsController < ApplicationController
  
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
     flash[:success] = "Welcome #{@chef.chefname} to MyRecipes App!"
     redirect_to chef_path(@chef)
   else 
     render 'new'
   end 
  end
  
  def show
    @chef = Chef.find(params[:id])
#Below, we define a second variable to hold the recipes from the first and paginate
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end 
  
  def edit
    @chef = Chef.find(params[:id])
  end
  
  def update
    @chef = Chef.find(params[:id])
    if @chef.update(chef_params)
      flash[:success] = "Your account was updated!"
      redirect_to @chef 
    else 
      render 'edit'
    end 
  end
  
  private
  
  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end 
  
end 