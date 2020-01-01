class CommentsController < ApplicationController
#Below, ensures we have a current_chef and that they're logged in to make the comment below.
  before_action :require_user
  
  def create
#BElow, we have to find the recipe we'll be assigning the comment to. We cannot do it with params[:id] because this
#is not recipes_controller. Instead we have to find the Recipe ID to assign the comment to. Debugger will tell us so.
    @recipe = Recipe.find(params[:recipe_id])
#Once the recipe is found now we want to create a comment. THe params we want to pass in is the :comment, which is ID
#and then the :description since that's the only other attribute we want to pass in when a comment is created. See
#"rails console" and type Comments.all to see the attributes assigned to it.
    @comment = @recipe.comments.build(comment_params)
#Next, we need the chef making the comment. It'd be the user logged in who is commenting, according to our "before" 
#enforcement above which permits only logged in users, and in this case, only logged in to comment.
    @comment.chef = current_chef 
    if @comment.save
#Below you set up the ActionCable, then its argument being the channel you want it to broadcast from. Then, a comma
#to specify what you want it to display.
      ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
#Below, we code out the FLash and Redirect so that the ActionCable can work in realtime
      # flash[:success] = "Comment posted successfully!"
      # redirect_to recipe_path(@recipe) #Back to Recipe Show Page
    else
      flash[:danger] = "Comment wasn't created."
#Below, we can't normally render the show page again, because it isn't a redirect. It's not a separate
#request because we don't have an @comments instance variable, the one in show.html.erb is empty. 
#So instead we redirect :back, meaning just back one page
      redirect_back(fallback_location: root_path)
#Two other options below, not working:
      #redirect_to recipe_path(@recipe) 
      #redirect_to :back
    end 
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:description)
  end
  
end