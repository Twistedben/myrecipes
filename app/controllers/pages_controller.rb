class PagesController < ApplicationController
  
  def home 
#Below, we're redirecting a logged in user as established in "application_controller.rb" to the all recipes page instead
#of the splash login page that a non-logged in user would be directed to. We go from clicking "MyRecipes" on the front
#end that takes us to "/pages/home" when not logged in, to "/chefs/show.html"
    redirect_to recipes_path if logged_in?
  end
  
end