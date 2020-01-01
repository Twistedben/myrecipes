class SessionsController < ApplicationController
#Serves the new form for login page
  def new
  
  end
#Handles form submissions, create the act of logging in
  def create
#From using debugger, we know that the params that the create actin was looking for was from the ":session" controller
#and it was retrieving [:email] and [:password]. We need to look for the user based on the email from the session that
#was entered on the front end. Since we don't need to use the variables created here in views, we don't need them to
#be instance variables, just plain variables will work like "chef". All our emails in the DB are downcase, so we have
#to enforce that. 
    chef = Chef.find_by(email: params[:session][:email].downcase)#This will assign "chef" with a matching email in the DB
#After we look for the chef we have to varify it actually exists. Below, we check two conditions to be true, if the
#chef is simply valid "if chef", meaning it's in the DB and we also check if the chef variable's password is authentic
#and in the DB, since the ".authenticate" method varifies passwords, and we supply that by providing the params. 
    if chef && chef.authenticate(params[:session][:password])#If chef is valid and& password authenticates, its successful
#Below, this sets up for an encrypted cookie for the session containing the logged in user's "chef id".
      session[:chef_id] = chef.id
      cookies.signed[:chef_id] = chef.id#Sets up Connection for "connect" method in "connection.rb"
      flash[:success] = "You have successfully logged in!"
      redirect_to chef #chef is short form for "chef_path(chef)"
    else
      flash.now[:danger] = "There was an issue with the login information." #We use ".now" to indicate ONE HTTP Request
      render 'new' #SHowing the login page again, but with the flash message above
    end
  end 
  
#Handles logging out
  def destroy
#Since logging in from the Create action above, we simply have to destroy that session cookie to logout
    session[:chef_id] = nil
    flash[:success] = "You have logged out!"
    redirect_to root_path
  end
  
end




