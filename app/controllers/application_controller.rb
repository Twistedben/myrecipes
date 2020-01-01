class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
#Below, turns the listed methods into helpers that can be used inside our views. We don't need "require_user" in views.
  helper_method :current_chef, :logged_in?
#Below, returns the user object (chef) who is logged in, used with checking who they are
  def current_chef
#Below, finds the current chef who is logged in from the session hash and their ID. The if statement makes it so this
#only occurs if there is a session for a logged in chef. This will automatically hit the DB whether or not the CHef
#was already logged in
    @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id] #But, the "||=" makes it so if the chef is there
#return it right away; If not, then return it using the code following the "=". This is optimization of code.
  end
  
  def logged_in?
#Due to the method above, we know that if "@current_chef" exists, we know that a chef is logged in and assigned. So we
#have to turn the "current_chef" method into a true or false within this method with the code below.
    !!current_chef #"!!" Turns any expression into a true or false boolean
  end
  
  def require_user 
  #This is for restricting actions if the user is logged in or not
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action!"
      redirect_to root_path
    end
  end
  
end
