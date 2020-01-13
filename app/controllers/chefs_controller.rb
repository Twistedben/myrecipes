class ChefsController < ApplicationController
  before_action :set_chef, only: [:show, :edit, :update, :destroy]
  #Below, we restrict logged in chefs from being able to modify another chef.
  before_action :require_same_user, only: [:edit, :update, :destroy]
  #Enforcing "require_admin method on the destroy action"
  before_action :require_admin, only: [:destroy]

  def index
    #Here, we are adding pagination to CHefs listing in Index
    # @chefs = Chef.paginate(page: params[:page], per_page: 5)
    @chefs = Chef.all
    @comments = Comment.all
    render component: "Chefs", props: { chefs: @chefs, comments: @comments }
  end

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      session[:chef_id] = @chef.id #This will automatically log in the chef after they create an account
      cookies.signed[:chef_id] = @chef.id #Allows newly created chefs realtime comments
      flash[:success] = "Welcome #{@chef.chefname} to MyRecipes App!"
      redirect_to chef_path(@chef)
    else
      render "new"
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
      render "edit"
    end
  end

  def destroy
    if !@chef.admin?
      @chef.destroy
      flash[:danger] = "Chef and All associated Recipes have been deleted"
      redirect_to chefs_path
    end
  end

  private

  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

  def set_chef
    @chef = Chef.find(params[:id])
  end

  #Below, we prevent the current user from being unable to edit chefs that don't belong to them, logged in. We also
  #check if the current chef is not an admin.
  def require_same_user
    if current_chef != @chef and !current_chef.admin?
      flash[:danger] = "You can only modify your own account!"
      redirect_to chefs_path
    end
  end

  #Below, we create a method that will restrict an action if the logged in user is not a admin.
  def require_admin
    if logged_in? && !current_chef.admin?
      flash[:danger] = "Only admin users can perform that action!"
      redirect_to root_path
    end
  end
end
