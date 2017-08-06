class MessagesController < ApplicationController
  before_action :require_user #Dependent on users being logged in for action to occur.

  def create
    @message = Message.new(message_params)
    @message.chef = current_chef #Supplied by the "before_action"
    if @message.save
      redirect_to chat_path #Ensures the new message shows on browser
    else 
      render 'chatrooms/show'
    end 
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content) 
  end 
  
end